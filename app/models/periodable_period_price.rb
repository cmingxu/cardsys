# -*- encoding : utf-8 -*-
class PeriodablePeriodPrice < ActiveRecord::Base
  attr_accessible :price, :period_price_id
  belongs_to :periodable, :polymorphic => true
  belongs_to :period_price
end
