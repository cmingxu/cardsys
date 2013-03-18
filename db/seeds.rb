 #-*- encoding : utf-8 -*-
 #This file should contain all the record creation needed to seed the database with its default values.
 #The data can then be loaded with the rake db:seed (or buildd alongside the db with db:setup).

 #Examples:

   #cities = City.build([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
   #Mayor.build(:name => 'Daley', :city => cities.first)

User.delete_all
Client.delete_all
Department.delete_all
Power.delete_all
Identity.delete_all

user = Identity.create(:email => "admin@example.com",:password => "admin01",:password_confirmation => "admin01")
bodewei = Client.create :name => "博徳维", :locked => false, :domain => "bdw"
aoyuan  = Client.create :name => "奥园",   :locked => false, :domain => "ay"
bodewei_admin = bodewei.users.create(:login => "bodewei_admin", :password => "admin01", :password_confirmation => "admin01", :user_name => "管理员", :role => User::CLINET_ADMIN)
aoyuan_admin  = aoyuan.users.create(:login => "aoyuan_admin", :password => "admin01", :password_confirmation => "admin01", :user_name => "管理员", :role => User::CLINET_ADMIN)
dep_admin_bodewei =  Department.create(:client => bodewei, :name => "_管理员")
dep_admin_aoyuan  =  Department.create(:client => aoyuan,  :name => "_管理员")

include ActionDispatch::Routing
include Rails.application.routes.url_helpers

config = YAML::load(ERB.new(IO.read(Rails.root + "config/menus_and_powers.yml")).result)
config.each_key do |menu|
  this_menu = config[menu]
  p = Power.create(:subject => this_menu.fetch('name'), :path => this_menu.fetch('default_path'))
  this_menu.fetch('submenus').try(:each_key) do |submenu|
    Power.create(:subject => this_menu.fetch('submenus')[submenu], :path => send(submenu))
  end
end

dep_admin_bodewei.powers = dep_admin_aoyuan.powers = Power.all.select {|p| !p.subject.start_with?("_")}
dep_admin_bodewei.save
dep_admin_aoyuan.save

bodewei_admin.departments << dep_admin_bodewei
aoyuan_admin.departments << dep_admin_aoyuan 
bodewei_admin.save
aoyuan_admin.save
