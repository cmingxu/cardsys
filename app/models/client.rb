# -*- encoding : utf-8 -*-

module Setting2SelectOptions
  include ActionView::Helpers::FormOptionsHelper 

  def to_options(key, default_value = nil)
    raise ArgumentError unless self.respond_to?(key)
    raise ArgumentError unless self.send(key).is_a?(Array)

    options_for_select(self.send(key), default_value)
  end
end

module DateTypeDeteminer
  # 看来这里得缓存到redis里面了
  def date_type(date = Date.today)
    if is_workday?(date)
      is_summer?(date) ?  "夏令时" : "冬令时"
    else
      "节假日"
    end
  end

  def is_workday?(date)
    is_user_defined_workday?(date) || (date.weekday? and !is_user_defined_holiday?(date))
  end

  def is_user_defined_holiday?(date)
    Vacation.all.any? {|v| v.includes?(date) and v.is_holiday? }
  end

  def is_user_defined_workday?(date)
    Vacation.all.any? {|v| v.includes?(date) and v.is_workday? }
  end

  def is_summer?(date)
    SiteSetting.summer_months.include?(date.month) 
  end
end



class Client < ActiveRecord::Base
  serialize :config, Hash

  include Setting2SelectOptions
  include DateTypeDeteminer

  SiteSetting.keys.each do |item, value|
    attr_accessor   item.to_sym
    attr_accessible item.to_sym
  end

  after_initialize :init_config
  before_save      :load_config_back

  def init_config
    self.config = Client.default_config.merge(self.config)
    self.config.each do |key, value|
      self.send "#{key}=", value
    end
  end

  def load_config_back
    self.config = Hash[
      Client.default_config.keys.collect{|key| [key, self.send("#{key}")] }
    ]
  end

  def self.default_config
    SiteSetting.to_hash
  end

end
