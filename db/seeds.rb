 #-*- encoding : utf-8 -*-
 #This file should contain all the record creation needed to seed the database with its default values.
 #The data can then be loaded with the rake db:seed (or buildd alongside the db with db:setup).

 #Examples:

   #cities = City.build([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
   #Mayor.build(:name => 'Daley', :city => cities.first)
#
PeriodPriceStatement = <<EOF
INSERT INTO `period_prices` VALUES (1,'室外场地非黄金时段',60.00,'34','','2012-05-26 03:36:31','2012-05-28 04:48:07',0,NULL,NULL),(2,'室外场地黄金时段',100.00,'34','','2012-05-26 03:38:47','2012-05-28 04:47:57',0,NULL,NULL),(3,'室外场地节假日',100.00,'6','','2012-05-26 03:40:08','2012-05-26 03:40:08',0,NULL,NULL),(4,'室内硬地非黄金时段',200.00,'34','','2012-05-26 03:41:38','2012-05-28 04:47:47',0,NULL,NULL),(5,'室内硬地黄金时段',300.00,'34','','2012-05-26 03:42:08','2012-05-28 04:47:38',0,NULL,NULL),(6,'室内硬地节假日',300.00,'6','','2012-05-26 03:42:40','2012-05-26 03:42:40',0,NULL,NULL),(7,'室内红土场非黄金时段',600.00,'34','','2012-05-26 03:43:49','2012-05-28 04:47:25',0,NULL,NULL),(8,'室内红土场黄金时段',800.00,'34','','2012-05-26 03:44:09','2012-05-28 04:47:12',0,NULL,NULL),(9,'室内红土场节假日',800.00,'6','','2012-05-26 03:44:46','2012-05-26 03:44:46',0,NULL,NULL),(10,'室内VIP硬地非黄金时段',200.00,'34','','2012-11-24 10:08:06','2012-11-24 10:08:06',0,NULL,NULL),(11,'室内VIP硬地黄金时段',300.00,'34','','2012-11-24 10:08:47','2012-11-24 10:08:47',0,NULL,NULL),(12,'室内VIP硬地节假日',300.00,'6','','2012-11-24 10:09:55','2012-11-24 10:09:55',0,NULL,NULL);
EOF

CardStatement = <<EOF
INSERT INTO `cards` VALUES (1,'5000元储值卡','balance_card','A',12,'2',0,1,0,'',0.00,'enabled','2012-05-26 05:02:53','2012-07-01 08:14:07',1000,5,30,0),(2,'10000元储值卡','balance_card','B',12,'2',0,1,0,'',0.00,'enabled','2012-05-26 05:05:39','2012-07-01 08:14:46',2000,7,30,0),(3,'20000元储值卡','balance_card','C',12,'2',0,2,0,'',0.00,'enabled','2012-05-26 05:08:28','2012-07-01 08:14:26',3000,10,30,0),(4,'资格5000元金卡','zige_card','D',12,'2',0,2,0,'',0.00,'enabled','2012-05-26 05:13:16','2012-07-01 08:14:55',1000,7,30,0),(5,'资格10000铂金卡','zige_card','E',12,'2',0,2,0,'',0.00,'enabled','2012-05-26 05:23:25','2012-07-01 08:15:07',2000,7,30,0),(7,'资格30000元钻石卡','zige_card','F',12,'2',0,3,0,'',0.00,'enabled','2012-05-26 05:27:40','2012-07-01 08:15:18',3000,10,30,0),(8,'室外场优惠卡(非黄金）','counter_card','S1',12,'1',0,1,0,'',0.00,'enabled','2012-05-26 05:35:07','2012-05-26 05:35:07',0,5,30,0),(9,'室外场优惠卡(黄金）','counter_card','S2',12,'1',0,1,0,'',0.00,'enabled','2012-05-26 05:35:50','2012-05-26 05:35:50',0,5,30,0),(11,'接待','balance_card','VIP',12,'2',0,0,0,'',0.00,'enabled','2012-07-25 06:01:22','2012-07-25 06:01:22',0,0,0,0),(12,'汪俊室外卡','balance_card','WW',12,'1',0,0,0,'',0.00,'enabled','2012-08-17 08:07:52','2012-08-17 08:07:52',0,0,0,0),(13,'汪俊室内卡','balance_card','WN',12,'1',0,0,0,'',0.00,'enabled','2012-08-17 08:08:38','2012-08-17 08:11:09',0,0,0,0),(14,'2013年20000元储值卡','balance_card','13C',12,'2',0,2,0,'2013年1月1日0点以后办卡的',0.00,'enabled','2012-12-28 06:15:03','2012-12-28 06:15:03',3000,10,30,0),(15,'2013年资格5000元金卡','zige_card','13D',12,'2',0,2,0,'2013年1月1日0点以后办卡的',0.00,'enabled','2012-12-28 06:19:14','2012-12-28 06:19:14',1000,7,30,0),(16,'2013年资格10000元铂金卡','zige_card','13E',12,'2',0,2,0,'2013年1月1日0点以后办卡的',0.00,'enabled','2012-12-28 06:23:49','2012-12-28 06:23:49',1000,7,30,0),(17,'2013年资格30000元钻石卡','zige_card','13F',12,'2',0,3,0,'2013年1月1日0点以后办卡的',0.00,'enabled','2012-12-28 06:27:08','2012-12-28 06:27:08',3000,10,30,0),(18,'2013年10000元储值卡','balance_card','13B',12,'2',0,1,0,'2013年1月1日0点以后办卡的',0.00,'enabled','2013-01-01 01:10:56','2013-01-01 01:10:56',2000,7,30,0),(19,'储值卡10000','balance_card','DX',12,NULL,0,0,0,'',0.00,'enabled','2013-03-30 12:08:00','2013-03-30 12:08:00',1,1,1,1);
EOF

CourtStatement = <<EOF
INSERT INTO `courts` VALUES (3,'室外D1',NULL,NULL,7,23,'','enabled','2012-05-26 03:54:35','2012-08-27 02:46:57','26',0),(4,'室外D2',NULL,NULL,7,23,'','enabled','2012-05-26 03:55:25','2012-08-27 02:47:04','26',0),(5,'室外D3',NULL,NULL,7,23,'','enabled','2012-05-26 03:55:50','2012-08-27 02:47:11','26',0),(6,'室外D4',NULL,NULL,7,23,'','enabled','2012-05-26 03:56:21','2012-08-27 02:47:20','26',0),(8,'室外C2',NULL,NULL,7,23,'','enabled','2012-05-26 04:00:29','2012-05-26 04:09:40','27',0),(9,'室外C3',NULL,NULL,7,23,'','enabled','2012-05-26 04:00:59','2012-05-26 04:10:03','27',0),(10,'室外C4',NULL,NULL,7,23,'','enabled','2012-05-26 04:01:29','2012-05-26 04:10:27','27',0),(11,'室外C5',NULL,NULL,7,23,'','enabled','2012-05-26 04:02:14','2012-05-26 04:13:19','27',0),(12,'室外C6',NULL,NULL,7,23,'','enabled','2012-05-26 04:02:38','2012-05-26 04:11:05','27',0),(13,'室外C7',NULL,NULL,7,23,'','enabled','2012-05-26 04:03:05','2012-05-26 04:11:26','27',0),(14,'室外C8',NULL,NULL,7,23,'','enabled','2012-05-26 04:03:42','2012-05-26 04:13:57','27',0),(15,'室内A1',NULL,NULL,7,23,'','enabled','2012-05-26 04:15:26','2012-05-26 04:15:26','29',0),(16,'室内A2',NULL,NULL,7,23,'','enabled','2012-05-26 04:16:12','2012-05-26 04:16:12','29',0),(17,'室内A3',NULL,NULL,7,23,'','enabled','2012-05-26 04:16:36','2012-05-26 04:16:36','29',0),(18,'室内A4',NULL,NULL,7,23,'','enabled','2012-05-26 04:16:59','2012-05-26 04:16:59','29',0),(19,'室内红土A5',NULL,NULL,7,23,'','enabled','2012-05-26 04:17:59','2012-06-20 03:11:51','29',0),(20,'室内红土A6',NULL,NULL,7,23,'','enabled','2012-05-26 04:18:42','2012-06-20 03:11:42','29',0),(21,'室内B1',NULL,NULL,7,23,'','enabled','2012-05-26 04:20:16','2012-05-26 04:20:16','30',0),(22,'室内B2',NULL,NULL,7,23,'','enabled','2012-05-26 04:20:44','2012-05-26 04:20:44','30',0),(23,'室内B3',NULL,NULL,7,23,'','enabled','2012-05-26 04:21:19','2012-05-26 04:21:19','30',0),(24,'室内B4',NULL,NULL,7,23,'','enabled','2012-05-26 04:21:37','2012-05-26 04:21:37','30',0),(25,'室内B5',NULL,NULL,7,23,'','enabled','2012-05-26 04:21:58','2012-05-26 04:21:58','30',0),(26,'室内B6',NULL,NULL,7,23,'','enabled','2012-05-26 04:22:26','2012-05-26 04:22:26','30',0),(27,'室外D5',NULL,NULL,7,23,'','enabled','2012-06-20 03:07:17','2012-08-27 02:46:41','26',0),(28,'室外D6',NULL,NULL,7,23,'','enabled','2012-06-20 03:07:56','2012-08-27 02:46:31','26',0),(29,'室外C9',NULL,NULL,7,23,'','enabled','2012-06-20 03:10:55','2012-08-30 05:48:18','27',0);
EOF

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

ActiveRecord::Base.connection.execute PeriodPriceStatement
ActiveRecord::Base.connection.execute CardStatement
ActiveRecord::Base.connection.execute CourtStatement

PeriodPrice.update_all("client_id = #{bodewei_admin.client_id}")
Card.update_all("client_id = #{bodewei_admin.client_id}")
Court.update_all("client_id = #{bodewei_admin.client_id}")
