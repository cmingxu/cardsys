class AdminController < ApplicationController
  before_filter :authenticate_identity!
  layout 'admin'
end
