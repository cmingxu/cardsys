class AddDomainToClients < ActiveRecord::Migration
  def change
    add_column :clients, :domain, :string, null: false, default: ''
  end
end
