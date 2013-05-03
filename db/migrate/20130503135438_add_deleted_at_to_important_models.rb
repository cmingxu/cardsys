class AddDeletedAtToImportantModels < ActiveRecord::Migration
  def change
    add_column :orders, :deleted_at, :timestamp
    add_column :balances, :deleted_at, :timestamp
    add_column :members, :deleted_at, :timestamp
    add_column :member_cards, :deleted_at, :timestamp
    add_column :order_items, :deleted_at, :timestamp
    add_column :non_members, :deleted_at, :timestamp
    add_column :member_card_granters, :deleted_at, :timestamp
  end
end
