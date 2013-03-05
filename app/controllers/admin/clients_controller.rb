# -*- encoding : utf-8 -*-
class Admin::ClientsController < ApplicationController
  before_filter :authenticate_identity!
  before_filter :load_client
  layout 'admin'

  def index
    @clients = Client.paginate(default_paginate_options)
  end

  def show
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def destroy
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to admin_clients_path, notice: '创建成功。' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to admin_clients_path, notice: '更新成功。' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def load_client
    @client = Client.find_by_id(params[:id])
  end
end
