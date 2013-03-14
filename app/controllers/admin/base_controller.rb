class Admin::BaseController < ApplicationController
  before_filter :authenticate_identity!
  skip_before_filter :require_user
  skip_before_filter :ensure_client_domain
  layout 'admin'
end
