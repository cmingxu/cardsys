# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # user roles
  SITE_ADMIN   = "site_admin".freeze
  CLINET_ADMIN = "client_admin".freeze
  NORMAL       = "normal".freeze

  include HasPinyinColumn
  include HashColumnState
  include Clientable

  set_pinyin_field :user_name_pinyin, :user_name

  has_many :department_users
  has_many :departments, :through => :department_users

  acts_as_authentic do |c|
    c.merge_validates_length_of_login_field_options(:allow_blank => true, :message => "登陆名长度")
    c.merge_validates_format_of_login_field_options(:allow_blank => true)
    c.merge_validates_length_of_password_field_options(:allow_blank => true, :message => "长度太短")
    c.merge_validates_length_of_password_confirmation_field_options(:allow_blank => true, :message => "长度太短")
  end

  validate :role, :presence => true
  before_validation do |r|
    r.role ||= User::NORMAL
  end

  def must_belongs_to_a_client?
    !self.site_admin?
  end

  def site_admin?
    self.role == User::SITE_ADMIN 
  end

  def client_admin?
    self.role == User::CLINET_ADMIN
  end

  def powers
    self.departments.collect(&:powers).flatten.uniq
  end

  def top_powers
    powers.select {|p| p.parent_id.zero?}
  end

  def menus
    self.powers.collect(&:subject)
  end

  def can_book_when_time_due?
    self.menus.include?("过期预订")
  end

  def can?(action)
    self.menus.include?(action)
  end

  def departments_names
    self.departments.collect(&:name).join(", ")
  end

  def  can_destroy?
   false 
  end
end
