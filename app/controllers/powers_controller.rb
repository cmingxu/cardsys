# -*- encoding : utf-8 -*-
class PowersController < ApplicationController
  def index
    @powers = Power.paginate_by_client(current_client.id, default_paginate_options)
  end

  def edit
    @power = Power.find params[:id]
  end

  def update
    @power = Power.find params[:id]
    if @power.update_attributes(params[:power])
      flash[:notice] = "更新成功"
    else
      flash[:notice] = "更新失败"
    end

    redirect_to :action => "index"
  end
end
