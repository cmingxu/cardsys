# -*- encoding : utf-8 -*-

module Setting2SelectOptions
  include ActionView::Helpers::FormOptionsHelper 

  def to_options(key, default_value = nil)
    raise ArgumentError unless self.respond_to?(key)
    raise ArgumentError unless self.send(key).is_a?(Array)

    options_for_select(self.send(key), default_value)
  end
end

module DateTypeDeteminer
  # 看来这里得缓存到redis里面了
  def date_type(date = Date.today)
    if is_workday?(date)
      #is_summer?(date) ?  "夏令时" : "冬令时"
      "平日"
    else
      "节假日"
    end
  end

  def is_workday?(date)
    is_user_defined_workday?(date) || (date.weekday? and !is_user_defined_holiday?(date))
  end

  def is_user_defined_holiday?(date)
    Vacation.all.any? {|v| v.includes?(date) and v.is_holiday? }
  end

  def is_user_defined_workday?(date)
    Vacation.all.any? {|v| v.includes?(date) and v.is_workday? }
  end

  def is_summer?(date)
    self.summer_months.split(",").include?(date.month) 
  end
end


class Client < ActiveRecord::Base
  has_many :users, :dependent => :destroy

  serialize :config, Hash

  include Setting2SelectOptions
  include DateTypeDeteminer

  SiteSetting.keys.each do |item, value|
    attr_accessor   item.to_sym
    attr_accessible item.to_sym
  end

  attr_accessible :domain, :users_attributes, :name, :balance, :contact, :phone, :address

  after_initialize :init_config
  before_save      :load_config_back

  validates_presence_of   :domain, :message => '球场子域名不能为空。'
  validates_uniqueness_of :domain, :message => '该域名已经被占用。'
  #validates :domain, :name, :balance, :contact, :phone, :address , :presence => true
  accepts_nested_attributes_for :users
  before_validation(:on => :create) do |client|
    client.users.first.password_confirmation = client.users.first.password unless client.users.first.nil?
  end

  after_create do |client|
    admin = client.users.first
    if admin
      dep = Department.create(:client => client, :name => "_管理员")
      dep.powers = Power.all
      admin.departments << dep
      admin.save
    end
  end


  def init_config
    self.config = ::Client.default_config.merge(self.config)
    self.config.each do |key, value|
      self.send "#{key}=", value
    end

    self.config.extend Setting2SelectOptions
  end

  def load_config_back
    self.config = Hash[
      Client.default_config.keys.collect{|key| [key, self.send("#{key}")] }
    ]
    p self.config
  end

  def self.default_config
    SiteSetting.to_hash
  end

  def period_by_date_and_start_hour(date, start_hour)
    date_type = self.date_type(date)
    # pp = PeriodPrice.where(:period_type => date_type)
    PeriodPrice.where("period_type=? AND start_time <= ? AND end_time >= ?", date_type, start_hour, start_hour + 1)
    # pp.select { |element| element.start_time <= start_hour && element.end_time >= start_hour + 1}
  end

  #取得某一天中给定时间段的时段价格
  def all_periods_in_time_span(date = Date.today, start_time=nil, end_time=nil)
    start_time ||= self.client.start_hour
    end_time   ||= self.client.end_hour
    date_type = self.date_type(date)

    pp = PeriodPrice.where(:period_type => date_type).order("start_time asc")
    pp.select{ |element| element.start_time < end_time && element.end_time > start_time }
  end

  def calculate_amount_in_time_spans(date, start_hour, end_hour)
    start_hour,end_hour = start_hour.to_i,end_hour.to_i
    period_prices = all_periods_in_time_span(date,start_hour,end_hour)
    period_prices.sort!{|fst,scd| scd.start_time <=> fst.start_time }
    amount,leave_end_hour = 0,end_hour
    period_prices.each do |period_price|
      condition, price = yield period_price
      realy_end_hour = [start_hour,period_price.start_time].max
      next unless condition
      amount += (leave_end_hour - realy_end_hour)*price
      leave_end_hour = realy_end_hour
    end
    amount
  end  


end
