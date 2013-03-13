# -*- encoding : utf-8 -*-
class Power < ActiveRecord::Base
  include Clientable

  has_many   :user_powers,:dependent => :destroy
  has_many :users,:through => :user_powers
  has_many   :department_powers,:dependent => :destroy
  has_many :children, :class_name => "Power", :foreign_key => :parent_id
  scope :tops, lambda { {:conditions =>  "parent_id = 0" }}

  def self.tree_top
    where(:parent_id => 0)
  end

  def self.all_tree_top
    where(:parent_id => 0)
  end

  def can_destroy?
    false
  end


end
