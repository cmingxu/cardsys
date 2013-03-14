class AddDomainToClients < ActiveRecord::Migration
  def change
    add_column :clients, :domain, :string, null: false, default: ''
    
    Client.all.each do |client|
      client.domain = "client#{client.id}"
      client.save
    end
  end
end
