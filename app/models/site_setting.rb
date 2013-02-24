# -*- encoding : utf-8 -*-
#
module Setting2SelectOptions
  include ActionView::Helpers::FormOptionsHelper 
  
  def to_options(key, default_value = nil)
    raise ArgumentError unless self.respond_to?(key)
    raise ArgumentError unless self.send(key).is_a?(Array)

    options_for_select(self.send(key), default_value)
  end
end


class SiteSetting < Settingslogic
  extend Setting2SelectOptions

  source "#{Rails.root}/config/site_setting.yml"
  namespace Rails.env
end

