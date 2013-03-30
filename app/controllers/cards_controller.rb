# -*- encoding : utf-8 -*-
class CardsController < ApplicationController
  before_filter :load_card, :only => [:show, :edit, :update, :destroy]

  def index
    @cards = Card.paginate_by_client(current_client.id, default_paginate_options)
  end

  def new
    @card = Card.new
    @period_prices = PeriodPrice.clientable(current_client.id).order("start_time")
  end

  def create
    @card = Card.new(params[:card])
    @period_prices = PeriodPrice.clientable(current_client.id).order("start_time")
    @card.client_id = current_client.id if current_client
    #设置卡的时段价格

    @card.period_prices = PeriodPrice.find params[:time_available].keys
    @card.periodable_period_prices.each do |element|
      element.price = params[:time_discount][element.periodable_id]
    end

    if @card.save
      redirect_to(cards_path, :notice => '卡信息创建成功！') 
    else
      render :action => "new" 
    end
  end

  def update
    @card.period_prices = PeriodPrice.find params[:time_available].keys
    @card.periodable_period_prices.each do |element|
      element.price = params[:time_discount][element.period_price_id.to_s]
      puts element.changed?
    end
    if @card.save
      redirect_to(cards_path, :notice => '卡信息修改成功！') 
    else
      render :action => "edit" 
    end
  end

  def destroy
    if @card.members_cards.first
      flash[:notice] = "此类型的卡已经有绑定，不能删除！"
    else
      @card.destroy
      flash[:notice] = "删除成功！"
    end
    redirect_to(cards_url) 
  end

  def switch_state
    @card = Card.find(params[:id])
    @card.switch_state!
    @card.state
    redirect_to(cards_url) 
  end

  def default_card_serial_num
    card = Card.find(params[:id])
    cardNo = card.card_prefix + member_card_num4(card)
    render :json => { :card_serial_num => cardNo }
  end

  def member_card_num4(card)
    last_member_card = card.members_cards.last
    last_member_card.nil? ? "00001" : last_member_card.card_serial_num[card.card_prefix.length..-1].succ
  end

  private

  def format_card_period_price(card)
    for period_price in PeriodPrice.clientable(current_client.id).order('start_time')
    end
  end

  def load_card 
    @card = Card.find(params[:id])
    @period_prices = PeriodPrice.order('start_time')
    @period_prices = @period_prices.clientable(current_client.id) if current_client
    @goods = Good.enabled
  end
end
