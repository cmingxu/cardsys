# -*- encoding : utf-8 -*-

class SettingsController < ApplicationController

  def index;;end

  def create

  end

  def modify
    params[:client].each do |key, value|
      if value =~ /true|false/
        params[:client][key] = value == "true" ? true : false
      end
    end
    p params
    p "debugger============================"
    flash[:notice] = current_client.update_attributes(params[:client]) ? "更新成功" : "更新失败"
    redirect_to settings_path
  end
end
