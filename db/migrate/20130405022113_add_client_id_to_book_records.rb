class AddClientIdToBookRecords < ActiveRecord::Migration
  def change
    add_column :book_records, :client_id, :integer
  end
end
