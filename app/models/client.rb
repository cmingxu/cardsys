class Client < ActiveRecord::Base
  serialize :config, Hash

  SiteSetting.keys.each do |item, value|
    attr_accessor   item.to_sym
    attr_accessible item.to_sym
  end

  after_initialize :init_config
  before_save      :load_config_back

  def init_config
    self.config = default_config.merge(self.config)
    self.config.each do |key, value|
      self.send "#{key}=", value
    end
  end

  def load_config_back
    self.config = Hash[
      SiteSetting.keys.collect{|key| [key, self.send("#{key}")] }
    ]
  end

  def default_config
    SiteSetting.to_hash
  end

end
