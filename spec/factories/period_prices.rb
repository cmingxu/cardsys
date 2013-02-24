# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define do
  factory :period_price do
    name: "室内VIP硬地节假日"
    start_time: 7
    end_time: 24
    price: 600
    period_type: SiteSetting.period_type.first
  end
end
