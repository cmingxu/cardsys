# -*- encoding : utf-8 -*-
#
#
module Logable
  extend ActiveSupport::Concern

  included do
    class_eval do
      has_many :logs, :as => :item
    end
  end

end
