# -*- encoding : utf-8 -*-
class PeriodablePeriodPrice < ActiveRecord::Base
  attr_accessible :price
  belongs_to :periodable, :polymorphic => true
  belongs_to :period_price
end
