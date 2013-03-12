# -*- encoding : utf-8 -*-
class CreatePeriodablePeriodPrices < ActiveRecord::Migration
  def self.up
    create_table :periodable_period_prices  do |t|
      t.string  :periodable_type
      t.integer :periodable_id
      t.integer :period_price_id
      t.decimal :price, :default => 0, :precision => 10, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :periodable_period_prices
  end
end
