class AddClientIdToPowers < ActiveRecord::Migration
  def change
    add_column :powers,      :client_id, :integer, null: false, default: 0
    add_column :departments, :client_id, :integer, null: false, default: 0

    add_column :rents,       :client_id, :integer, null: false, default: 0
    add_column :logs,        :client_id, :integer, null: false, default: 0

    add_column :order_items, :client_id, :integer, null: false, default: 0
  end
end
