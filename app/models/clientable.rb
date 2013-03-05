# -*- encoding : utf-8 -*-

module Clientable
  extend ActiveSupport::Concern

  included do
    belongs_to :client
    scope :clientable, lambda {|client_id| where(:client_id => client_id) }
    validate :ensure_client_exist
  end

  module ClassMethods
    def paginate_by_client(client_id, params)
      clientable(client_id).paginate(params)
    end
  end

  module InstanceMethods
    def ensure_client_exist
      errors.add(:client_id, "你不属于任何客户，请联系管理员。") unless self.client
    end
  end
end

