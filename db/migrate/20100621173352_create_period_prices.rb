# -*- encoding : utf-8 -*-
class CreatePeriodPrices < ActiveRecord::Migration
  def self.up
    create_table :period_prices do |t|
      t.string :name
      t.integer :start_time, :default => 7
      t.integer :end_time, :default => 7
      t.decimal :price, :default => 0, :precision => 10, :scale => 2
      t.string  :period_type 
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :period_prices
  end
  
end
