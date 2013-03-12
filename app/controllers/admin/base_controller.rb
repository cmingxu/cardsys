class Admin::BaseController < ApplicationController
  before_filter :authenticate_identity!
  layout 'admin'
end
