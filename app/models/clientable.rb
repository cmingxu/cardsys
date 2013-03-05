module Clientable
  extend ActiveSupport::Concern

  included do
    belongs_to :client
    scope :clientable, lambda {|client_id| where(:client_id => client_id) }
  end

  module ClassMethods

  end

  module InstanceMethods

  end
end

