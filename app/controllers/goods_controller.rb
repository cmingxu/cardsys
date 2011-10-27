class GoodsController < ApplicationController
  def autocomplete_name
    @names = @goods.collect(&:name) rescue []
    render :inline => @names.to_json
  end


  def autocomplete_good
    goods = []
    @goods.each do |g| goods << {:label => g.name,:value => g.name,:id => g.id,:price => g.price} end
    render :inline => goods.to_json
  end


  def index
    @p = params[:p]
    @good_type = params[:good_type]
    @name = params[:name]
    @category = Category.find_by_id(@good_type)
    @goods = @category.nil? ? Good.order("id desc") :  @category.all_goods.order("id desc")
    @goods = @goods.paginate(default_paginate_options)
    render :template =>  '/goods/index'
  end


  def find_goods
    @good_type = params[:good_type]   
    @name = params[:name]
    @category = Category.find_by_id(@good_type)
    @goods = @category.nil? ? Good.order("id desc") :  @category.all_goods.order("id desc")
    @goods = @goods.valid_goods
    @goods = @goods.paginate(:page => params[:page]||1)
    render :action => "goods",:layout => "small_main" 
  end


  def show
    @good = Good.find(params[:id])
  end

  def new
    @good = Good.new
  end

  def edit
    @good = Good.find(params[:id])
  end

  def create
    @good = Good.new(params[:good])
    @good.count_total_now = @good.count_back_stock
    @good.count_front_stock = 0
    if @good.save
      redirect_to(@good, :notice => '商品信息添加成功！') 
    else
      render :action => "new" 
    end
  end

  def update
    @good = Good.find(params[:id])
    @good.count_total_now = @good.count_back_stock + @good.count_front_stock

    if @good.update_attributes(params[:good])
      redirect_to(@good, :notice => '商品信息修改成功！') 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @good.destroy

    redirect_to goods_url
  end

  def store_manage_index
    @p = params[:p]
    @good = Good.find(params[:id])
    render :layout => false
  end

  def store_manage_update
    @good = Good.find(params[:id])
    @p = params[:p]
    count_back_stock_out = params[:good][:count_back_stock_out].to_i
    count_back_stock_in  = params[:good][:count_back_stock_in].to_i
    count_front_stock_in = params[:good][:count_front_stock_in].to_i
    @good.count_back_stock  += (count_back_stock_in - count_back_stock_out - count_front_stock_in )
    @good.count_front_stock += count_front_stock_in
    @good.count_total_now   = @good.count_back_stock + @good.count_front_stock
    msg = @good.save ? 'yes' : 'no'
    render :text => msg
  end

  def change_status
    @good = Good.find(params[:id])
    @good.update_attribute("status", params[:status])
    respond_to do |format|
      format.html { redirect_to(goods_url) }
      format.xml  { head :ok }
    end
  end

  def goods
    if params[:id].to_i > 0
      @goods = [Good.find(params[:id])]
    else
      @goods = Good.valid_goods.order('sale_count desc').limit(20)
    end
    render :layout => "small_main"
  end

  def to_buy
    @goods = Good.valid_goods.order('sale_count desc').limit(20)
    render :action => 'goods'
  end

  def add_to_cart
    goods = []
    (params[:goods]||[]).map{|hash_good|
      next if  hash_good[:count].to_i <= 0
      good = Good.find(hash_good[:id])
      good.order_count = hash_good[:count].to_i
      goods << good
    }
    order = Order.find(params[:order_id])
    unless (good_items = order.order_goods(goods)).blank?
      render :partial => "/orders/order_item", :locals => {:good_items => good_items,:order => order}
    else
    end
  end

end
