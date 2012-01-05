class Member < ActiveRecord::Base
  include HashColumnState

  scope :autocomplete_for, lambda {|name| 
    where("state= 'enabled' and (LOWER(name_pinyin) LIKE :member_name or LOWER(name) like :member_name or LOWER(pinyin_abbr) like :member_name)", {:member_name => "#{name.downcase}%"}).limit(10).order("pinyin_abbr ASC") }

  has_many :orders
  has_many :members_cards
  has_many :balances
  has_many :member_card_granters, :foreign_key => "granter_id"
  has_many :granted_member_cards, :class_name => "MembersCard", :through => :member_card_granters, :source => :members_card, :uniq => true

  validates :name, :presence => {:message => "名称不能为空！"}
  validates :mobile, :format => {:with =>/^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/,:message => '手机号为空或者手机号格式不正确！', :allow_blank => false}
  validates :telephone, :numericality => {:only_integer => true, :message => "电话号码必须为数字！", :allow_blank => true}, :length => {:minimum => 8, :maximum => 11, :message => "电话必须大于8位小于11位！", :allow_blank => true}
  validates :email, :format => {:with =>/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/, :allow_blank => true,:message => '邮箱格式不正确！'}
  validates :cert_num, :uniqueness => {:on => :create, :message => '证件号已经存在！', :if => Proc.new { |member| !member.cert_num.nil? && !member.cert_num.blank? }}#证件号唯一

  validate :granter_no_more_than_max_num
  before_save :geneate_name_pinyin
  attr_accessor :members_card_id

  after_create do |member|
    if member.granter?
      mc = MembersCard.find(members_card_id)
      mc.granters << member
      mc.save
    end
  end

  def granter_no_more_than_max_num
    return true unless self.granter
    mc = MembersCard.find(members_card_id)
    self.errors.add(:base, "此卡最大授权人数已达上限") if mc.max_granter_due?
  end

  def geneate_name_pinyin
    pinyin = PinYin.new
    self.name_pinyin = pinyin.to_pinyin(self.name) if self.name
    self.pinyin_abbr = pinyin.to_pinyin_abbr(self.name) if self.name
  end

  def has_card?
    all_members_cards.present?
  end

  def is_granter_of_card?(card)
   card.granters.include? self
  end

  def all_members_cards
    members_cards.enabled + granted_member_cards.enabled
  end

  def member_card_left_times
   self.all_members_cards.collect(&:left_times).sum
  end

  def member_card_left_fees
   self.all_members_cards.collect(&:left_fee).sum
  end

  def member_consume_amounts
    self.orders.inject(0){|s,o| s + (o.court_book_record.try(:hours) || 0)} 
  end

  def latest_comer_date
    self.orders.last.try(:order_time).try(:to_chinese_ymd) || "无"
  end

  def recharge_fees
    RechargeRecord.where(:member_id => self.id).sum('recharge_fee')
  end

  def recharge_times
    RechargeRecord.where(:member_id => self.id).sum('recharge_times')
  end

  def balance_times
    0
  end

  def use_card_price_amount
    0
  end

  def use_cash_amount
  end

  def use_card_amount
  end
end
