# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create(:login => "admin",:password => "admin01",:password_confirmation => "admin01",:user_name => "超级管理员")


Power.delete_all

a = Power.create(:parent_id => 0,:subject => "基础信息管理")
a.children.create(:subject => "时段价格管理")
a.children.create(:subject => "卡模版管理")
a.children.create(:subject => "场地管理")
a.children.create(:subject => "节假日管理")
a.children.create(:subject => "教练管理")

a= Power.create(:parent_id => 0,:subject => "会员管理")
a.children.create(:subject => "会员列表")
a.children.create(:subject => "添加会员")
a.children.create(:subject => "高级查询")

a= Power.create(:parent_id => 0,:subject => "会员卡管理")
a.children.create(:subject => "会员卡绑定")
a.children.create(:subject => "会员卡充值")
a.children.create(:subject => "授权人管理")
a.children.create(:subject => "停卡激活管理")

a=Power.create(:parent_id => 0,:subject => "场地预定")
a.children.create(:subject => "新场地预定")
a.children.create(:subject => "新场地周期性预定")
a.children.create(:subject => "场地预定情况查询")
a.children.create(:subject => "教练日程查询")

a=Power.create(:parent_id => 0,:subject => "商品库存管理")
a.children.create(:subject => "商品基本信息管理")
a.children.create(:subject => "商品后台库存管理")
a.children.create(:subject => "商品前台出库管理")

a=Power.create(:parent_id => 0,:subject => "分析报表")
a.children.create(:subject => "教练分账报表")
a.children.create(:subject => "时间段内收入报表")
a.children.create(:subject => "会员消费明细")
a.children.create(:subject => "场地使用率")

a=Power.create(:parent_id => 0,:subject => "消费结算")
a.children.create(:subject => "场地待结算列表")
a.children.create(:subject => "场地已结算列表")
a.children.create(:subject => "购买商品")

a=Power.create(:parent_id => 0,:subject => "权限管理")
a.children.create(:subject => "用户管理")
a.children.create(:subject => "部门管理")
a.children.create(:subject => "连锁店管理")

a=Power.create(:parent_id => 0,:subject => "系统管理")
a.children.create(:subject => "修改密码")
a.children.create(:subject => "操作日志")
a.children.create(:subject => "数据备份")
a.children.create(:subject => "关于软件")

Power.create(:parent_id => 0,:subject => "过期预定")


Department.delete_all

Department.create(:name => "前台")
Department.create(:name => "财务部")
Department.create(:name => "会员部")
Department.create(:name => "培训部")

user.departments << Department.all
user.powers << Power.all
user.save
