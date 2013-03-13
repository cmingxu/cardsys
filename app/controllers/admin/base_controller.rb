class Admin::BaseController < ApplicationController
  before_filter :authenticate_identity!
  skip_before_filter :require_user
  layout 'admin'
end
