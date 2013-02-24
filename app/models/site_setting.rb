# -*- encoding : utf-8 -*-
class SiteSetting < Settingslogic
  source "#{Rails.root}/config/site_setting.yml"
  namespace Rails.env
  load!

  include ActionView::Helpers::FormOptionsHelper 

  def self.method_missing(*args)
    method_name = args.first
    if not method_name.end_with?('options')
      super
    else
      default_value = args[1]
      options_for_select(self.send(method_name.chomp("_options")))
    end
  end

end
