# encoding: utf-8

class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      # 名称
      t.string  :name,    null: false, default: ''
      # 账户余额
      t.decimal :balance, default: 0, precision: 10, scale: 2
      # 联系人
      t.string  :contact, null: false, default: ''
      # 联系人手机
      t.string  :phone,   null: false, default: ''
      # 联系人地址
      t.string  :address, null: false, default: ''
      # 啥时候该交钱了
      t.integer :expired, null: 12
      # 账户是否被锁定
      t.boolean :locked,  null: false, default: false

      t.timestamps
    end
  end
end
