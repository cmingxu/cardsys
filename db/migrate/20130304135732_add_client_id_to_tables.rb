class AddClientIdToTables < ActiveRecord::Migration
  def change
    add_column :users,         :client_id, :integer, null: false, default: 0

    add_column :period_prices, :client_id, :integer, null: false, default: 0
    add_column :cards,         :client_id, :integer, null: false, default: 0
    add_column :courts,        :client_id, :integer, null: false, default: 0
    add_column :vacations,     :client_id, :integer, null: false, default: 0
    add_column :coaches,       :client_id, :integer, null: false, default: 0
    add_column :lockers,       :client_id, :integer, null: false, default: 0


    add_column :orders,        :client_id, :integer, null: false, default: 0
    add_column :goods,         :client_id, :integer, null: false, default: 0

    add_column :members,       :client_id, :integer, null: false, default: 0
    add_column :member_cards,  :client_id, :integer, null: false, default: 0
  end
end
