# -*- encoding : utf-8 -*-
#

class SiteSetting < Settingslogic
#  extend Setting2SelectOptions
#  extend DateTypeDeteminer

  source "#{Rails.root}/config/site_setting.yml"
  namespace Rails.env
end

