# encoding: utf-8
class MigrateClient < ActiveRecord::Migration
  def up
    client = Client.create :name => "博德维", :contact => "李际阳", :phone => "13241931795", :address => "NewYork"

    User.update_all(:client_id => client.id)
    PeriodPrice.update_all(:client_id => client.id)
    Card.update_all(:client_id => client.id)
    Court.update_all(:client_id => client.id)
    Vacation.update_all(:client_id => client.id)
    Coach.update_all(:client_id => client.id)
    Locker.update_all(:client_id => client.id)
    Order.update_all(:client_id => client.id)
    Good.update_all(:client_id => client.id)
    Member.update_all(:client_id => client.id)
    MembersCard.update_all(:client_id => client.id)
    Power.update_all(:client_id => client.id)
    Department.update_all(:client_id => client.id)
    Rent.update_all(:client_id => client.id)
    Log.update_all(:client_id => client.id)
    OrderItem.update_all(:client_id => client.id)
  end

  def down
  end
end
