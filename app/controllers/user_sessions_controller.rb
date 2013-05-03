# -*- encoding : utf-8 -*-
class UserSessionsController < ApplicationController
  skip_before_filter :require_user
  skip_before_filter :authentication_required

  def new
    if current_user and current_client and Rails.env == 'production'
      redirect_to root_url(:subdomain => current_client.domain) and return
    elsif current_user
      redirect_to orders_path and return
    end
    @user_session = UserSession.new
    render :layout => false
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_path
      # redirect_back_or_default root_or_admin_root_path 
      #if Rails.env == 'production'
        #redirect_to root_url(:subdomain => current_client.domain)
      #else
        #redirect_to '/'
      #end
    else
      render :action => "new", :layout => false
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    flash[:notice] = "退出系统!"
    redirect_to new_user_session_url
  end

  protected
  # 根据用户类型（全站管理员或者是client的管理员跳转到不同页面）
  def root_or_admin_root_path
    @user_session.user.site_admin? ? admin_dashboard_path : root_path
  end
end

