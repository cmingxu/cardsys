class MemberCard < ActiveRecord::Base

  include MemberCardOrder
  
  belongs_to  :card
  belongs_to  :member
  has_many    :orders

  CARD_STATUS_0 = 0 #正常
  CARD_STATUS_1 = 1 #已注销
  
  Free_Count_Limit = 2
  Free_Amount_limit = 500

  #  #default_scope where({:catena_id => current_catena.id})

  def calculate_amount_in_time_span(date,start_hour,end_hour)
    if card.is_counter_card?
      end_hour - start_hour
    else
      card.calculate_amount_in_time_span(date,start_hour,end_hour)
    end
  end

  def is_expired?
    expire_date <= DateTime.now
  end

  def is_avalible?
    !is_expired? && is_status_valid?
  end

  def is_useable_in_time_span?(book_record)
    card.is_useable_in_time_span?(book_record.record_date,book_record.start_hour,book_record.end_hour)
  end
  
  #TODO
  def should_advanced_order?(start_hour,end_hour)
    true
    #card.should_advanced_order?
  end
  
  def has_enough_money_to_record?(record)
    #TODO
  end

  def has_enough_money_to_balance?(balance)
    left_mouny_order_counter(balance) > balance.amount_by_card
  end

  def member_card_type_opt
    return "" if self.card.nil?
    card.is_counter_card? ? "充次" : "充值"
  end

  def member_card_granters
    mcgs = []
    MemberCardGranter.where(:member_card_id => self.id).each { |e|
      mcgs << Member.find(e.member_id ).first.name
    }
    mcgs
  end

  def left_fee_value
    unless card.is_zige_card?
      card.is_counter_card? ? "#{left_times.to_i} 次" : "￥#{left_fee.to_i}"
    else
      "￥#{left_fee.to_i}元;#{left_times.to_i} 次"
    end
  end
   
  def left_mouny_order_counter(balance = nil)
    card.is_counter_card? ||
      (card.is_zige_card? && balance && balance.use_card_counter_to_balance?) ?
      left_times : left_fee
  end
   
  def is_status_valid?
    self.status == 0
  end

  def member_card_status_opt
    self.status == 0 ? "正常" : "已注销"
  end
  
  def status_desc
    desc_str = member_card_status_opt
    desc_str << "*已过期"if is_expired?
    desc_str
  end
  
  def has_less_count?
    (card.is_counter_card? || card.is_zige_card?) && left_times < Free_Count_Limit
  end
  
  def has_less_fee?
    (!card.is_counter_card? || card.is_zige_card?) && left_fee < Free_Amount_limit
  end
  
  def less_fee_desc
    desc = ''
    desc << "卡余次不足#{Free_Count_Limit},请及时冲次" if has_less_count? 
    desc << "卡余额不足#{Free_Amount_limit}元，请及时充值" if has_less_fee?
  end
  
  def order_tip_message
    msg = []
    msg << "卡已经过期，或者状态不正常" unless is_avalible?
    msg << less_fee_desc   unless less_fee_desc.blank?
    msg.join(';')
  end
  
  #TODO
  def balance(order)
    balance_record = Balance.find_by_order_id(order.id)
    if card.is_counter_card? || (card.is_zige_card? && balance_record.use_card_counter_to_balance?)
      self.left_times -= balance_record.count_amount
    else
      if balance_record.use_card_to_balance_book_record?
        self.left_fee -= balance_record.book_record_realy_amount.to_i
      end
      if balance_record.use_card_to_balance_goods? 
        raise "卡#{card.card_serial_num}不能购买商品" unless order.should_use_card_to_balance_goods?
        self.left_fee -= balance_record.goods_realy_amount.to_i
      end
    end
    save
  end
  
end
