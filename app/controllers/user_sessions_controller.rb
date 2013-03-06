# -*- encoding : utf-8 -*-
class UserSessionsController < ApplicationController
  skip_before_filter :require_user
  skip_before_filter :authentication_required

  def new
    @user_session = UserSession.new
    render :layout => false
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default root_or_admin_root_path 
    else
      render :action => "new", :layout => false
    end
  end

  def destroy
    current_user_session.destroy
    @current_user = nil if @current_user
    flash[:notice] = "退出系统!"
    redirect_to new_user_session_url
  end

  protected
  # 根据用户类型（全站管理员或者是client的管理员跳转到不同页面）
  def root_or_admin_root_path
    @user_session.user.site_admin? ? admin_dashboard_path : root_path
  end
end

