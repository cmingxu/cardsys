# -*- encoding : utf-8 -*-
class PeriodablePeriodPrice < ActiveRecord::Base
  belongs_to :periodable, :polymorphic => true
  belongs_to :period_price
end
