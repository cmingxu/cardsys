class ChangeIntegerStartTimeToDatetime < ActiveRecord::Migration
  def up
    remove_column :book_records, :start_hour
    remove_column :book_records, :end_hour
    remove_column :period_prices, :start_time
    remove_column :period_prices, :end_time
    add_column :book_records, :start_time, :datetime
    add_column :book_records, :end_time, :datetime
    add_column :period_prices, :start_time, :integer
    add_column :period_prices, :end_time, :integer
  end

  def down
    remove_column :book_records, :start_time
    remove_column :book_records, :end_time
    remove_column :period_prices, :start_time
    remove_column :period_prices, :end_time
    add_column :book_records, :start_hour, :integer
    add_column :book_records, :end_hour, :integer
    add_column :period_prices, :start_time, :integer
    add_column :period_prices, :end_time, :integer
  end
end
