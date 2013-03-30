# -*- encoding : utf-8 -*-
class PeriodPrice < ActiveRecord::Base
  include Clientable

  has_many :periodable_period_prices

  validates :name,  :presence => {:message => "时段名称不能为空！"}
  validates :price, :numericality => {:message => "时段价格必须为数字！"}

  validate :validate_start_time_end_time
  validate :no_overlap_allowed
  validates_presence_of :start_time, :end_time, :message => "时段开始时间和结束时间不能空"

  scope :in_time_span, lambda { |client, start_time = nil, end_time = nil|
    start_time ||= client.start_hour
    end_time   ||= client.end_hour
    where("start_time < ? AND end_time > ?", end_time, start_time).order('start_time asc')
  }

  scope :by_period_type, lambda { |period_type|
    where(:period_type => period_type)
  }

  def validate_start_time_end_time
    self.errors.add(:start_time, "开始时间应小于结束时间") if self.start_time >= self.end_time 
  end

  def no_overlap_allowed
    existing_pp = self.class.where({ :period_type => self.period_type, :client_id => self.client_id })
    self.errors.add(:start_time, "时段冲突， 请调整开始或者结束时间") if existing_pp.any?{ |pp| pp.overlaps? self }
  end

  def overlaps?(other)
    self.period_type == other.period_type && ((start_time - other.end_time) * (other.start_time - end_time) >= 0)
  end

  def is_fit_for?(date)
    period_type == self.client.date_type(date)
  end

  def is_in_time_span(date = Date.today, start_hour = nil, end_hour = nil)
    start_hour ||= self.client.start_hour
    end_hour   ||= self.client.end_hour
    date_type = self.client.date_type(date||Date.today)
    date_type && period_type == date_type.id && start_time < end_hour && end_time > start_hour
  end

  #取得某一天中给定时间段的时段价格
  def self.all_periods_in_time_span(date = Date.today, start_time=nil, end_time=nil)
    start_time ||= self.client.start_hour
    end_time   ||= self.client.end_hour
    date_type = self.client.date_type(date || Date.today)

    pp = PeriodPrice.where(:period_type => date_type).order("start_time asc")
    pp.select{ |element| element.start_time < end_time && element.end_time > start_time }
  end

  def self.calculate_amount_in_time_spans(date, start_hour, end_hour)
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

  def can_destroy?
    self.periodable_period_prices.blank?
  end

end

