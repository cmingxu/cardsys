# -*- encoding : utf-8 -*-
class Department < ActiveRecord::Base
  include Clientable

  validates :name, :presence => {:message => "名称不能为空！"}
  validates :name, :uniqueness => { :message => '名称已经存在了！', :scope => :client_id}

  has_many :department_users
  has_many :users, :through => :department_users
  has_many :department_powers
  has_many :powers, :through => :department_powers

  scope :viewable_to_client, where("name not like '\\_%'")


  def has_power? power
    self.powers and self.powers.include?(power)
  end

  def can_view?
    false
  end
end
