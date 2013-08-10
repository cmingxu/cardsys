# -*- encoding : utf-8 -*-

module Clientable

  def self.included base
    base.class_eval do
      belongs_to :client
      scope :clientable, lambda {|client_id| where(:client_id => client_id) }
      validate :ensure_client_exist
      include InstanceMethods
    end

    base.extend ClassMethods
  end

  module ClassMethods
    def paginate_by_client(client_id, params)
      clientable(client_id).paginate(params)
    end
  end

  module InstanceMethods
    def must_belongs_to_a_client?
      true
    end

    def ensure_client_exist
      errors.add(:client_id, "你不属于任何球场，请联系管理员。") if self.must_belongs_to_a_client? && self.client_id.blank? && self.persisted?
    end
  end
end

