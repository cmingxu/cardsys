# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or buildd alongside the db with db:setup).
#
# Examples:
#
#   cities = City.build([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.build(:name => 'Daley', :city => cities.first)

user = User.create(:login => "admin",:password => "admin01",:password_confirmation => "admin01",:user_name => "超级管理员", :role => User::SITE_ADMIN)

Power.delete_all

a = Power.new(:parent_id => 0,:subject => "基础信息管理")
a.children.build(:subject => "时段价格管理")
a.children.build(:subject => "卡模版管理")
a.children.build(:subject => "场地管理")
a.children.build(:subject => "节假日管理")
a.children.build(:subject => "教练管理")
a.save

a= Power.new(:parent_id => 0,:subject => "会员管理")
a.children.build(:subject => "会员列表")
a.children.build(:subject => "添加会员")
a.children.build(:subject => "高级查询")
a.save

a= Power.new(:parent_id => 0,:subject => "会员卡管理")
a.children.build(:subject => "会员卡绑定")
a.children.build(:subject => "会员卡充值")
a.children.build(:subject => "授权人管理")
a.children.build(:subject => "停卡激活管理")
a.save

a=Power.new(:parent_id => 0,:subject => "场地预定")
a.children.build(:subject => "新场地预定")
a.children.build(:subject => "新场地周期性预定")
a.children.build(:subject => "场地预定情况查询")
a.children.build(:subject => "教练日程查询")
a.save

a=Power.new(:parent_id => 0,:subject => "商品库存管理")
a.children.build(:subject => "商品基本信息管理")
a.children.build(:subject => "商品后台库存管理")
a.children.build(:subject => "商品前台出库管理")
a.save

a=Power.new(:parent_id => 0,:subject => "分析报表")
a.children.build(:subject => "教练分账报表")
a.children.build(:subject => "时间段内收入报表")
a.children.build(:subject => "会员消费明细")
a.children.build(:subject => "场地使用率")
a.save

a=Power.new(:parent_id => 0,:subject => "消费结算")
a.children.build(:subject => "场地待结算列表")
a.children.build(:subject => "场地已结算列表")
a.children.build(:subject => "购买商品")
a.save

a=Power.new(:parent_id => 0,:subject => "权限管理")
a.children.build(:subject => "用户管理")
a.children.build(:subject => "部门管理")
a.children.build(:subject => "连锁店管理")
a.save

a=Power.new(:parent_id => 0,:subject => "系统管理")
a.children.build(:subject => "修改密码")
a.children.build(:subject => "操作日志")
a.children.build(:subject => "数据备份")
a.children.build(:subject => "关于软件")
a.save

Power.new(:parent_id => 0,:subject => "过期预定").save
a.save


user.save

# initial clients like "博徳维 and 奥园"
bodewei = Client.new :name => "博徳维", :locked => false
aoyuan  = Client.new :name => "奥园",   :locked => false

bodewei.save
aoyuan.save

bd = Department.new(:name => "球场管理员", :client => bodewei)
db.powers = Power.all
ad = Department.new(:name => "球场管理员", :client => aoyuan)
ad.powers = Power.all

db.save 
ad.save

bodewei.users.create(:login => "bodewei_admin", :password => "admin01", :password_confirmation => "admin01", :user_name => "管理员", :role => User::CLINET_ADMIN)
aoyuan.users.create(:login => "aoyuan_admin", :password => "admin01", :password_confirmation => "admin01", :user_name => "管理员", :role => User::CLINET_ADMIN)



