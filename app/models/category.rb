class Category < ActiveRecord::Base
  has_many :goods,:foreign_key => "good_type"
  acts_as_tree :order => "position"
  validate :category_stack_should_not_too_deep
  

  def category_stack_should_not_too_deep
    self.errors.add(:base,"分类层级不能超过两层")  if self.has_grantpa?
  end

  def has_grantpa?
    begin
      self.parent.parent
    rescue
      return false
    end
  end

  class << self
    def roots_b
      find(:all,:conditions => {:parent_id => 0},:order => "position")
    end
  end
end
