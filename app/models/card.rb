# -*- encoding : utf-8 -*-
class Card < ActiveRecord::Base
  include HashColumnState
  include Clientable

  CONSUME_TYPE_1 = 1 #场地消费
  CONSUME_TYPE_2 = 2 #可买商品

  CARD_TYPE = {
    "balance_card" => "储值卡",
    "counter_card" => "计次卡",
    "zige_card" => "资格卡"
  }
  
  has_many :members_cards
  has_many :periodable_period_prices, :as => :periodable, :autosave => true
  has_many :period_prices, :through => :periodable_period_prices

  validates :name, :presence => {:message => "卡名称不能为空！"}, :uniqueness => {:message => '卡名称已经存在! '}
  validates :card_prefix, :presence => {:message => "卡前缀不能为空！"}
  validates :expired, :numericality => true, :presence => {:message => "有效期不能为空！"}
  with_options(:only_integer => true, :greater_than => -1, :message => "必须为非负整数") do |woo|
    woo.validates_numericality_of :min_time 
    woo.validates_numericality_of :min_amount
    woo.validates_numericality_of :min_count
  end

  before_save do
    self.min_count = 0 if self.min_count.nil?
    self.min_amount = 0 if self.min_amount.nil?
    self.min_time = 0 if self.min_time.nil?
  end

  CARD_TYPE.each do |ctype, name|
    define_method "is_#{ctype}?" do
      self.card_type == ctype
    end
  end

  def card_balance_desc
    self.is_counter_card? ? "#{self.counts||0}次" : "#{self.balance||0}元"
  end

  def total_money_in_time_span(court_book_record)
    total_price = 0
    court_book_record.period_prices.each do |period_price|
      real_start_hour = [court_book_record.start_hour, period_price.start_time / 3600].max
      real_end_hour  =  [court_book_record.end_hour, period_price.end_time / 3600].min
      price = self.periodable_period_prices.first(:conditions => {:period_price_id => period_price.id}).try(:price) || 0
      total_price += (real_end_hour - real_start_hour) * price
      leave_end_hour = real_end_hour
    end
    total_price    
  end

  def should_advanced_order?
    is_member_card?
  end

  def card_type_opt
    (is_member_card? || is_balance_card?) ? "充值" : "充次"
  end

  def is_consume_goods?
    self.consume_type == CONSUME_TYPE_2
  end

  def card_type_in_chinese
    CARD_TYPE[card_type] 
  end

  def can_destroy?
    true
  end
end

