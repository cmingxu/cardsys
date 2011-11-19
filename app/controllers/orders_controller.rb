class OrdersController < ApplicationController

  def index
    @courts       = Court.enabled
    @date = params[:date].blank? ? Date.today : Date.parse(params[:date])
    @daily_periods   = PeriodPrice.all_periods_in_time_span(@date)
    @predate      = @date.yesterday.strftime("%Y-%m-%d")
    @nextdate     = @date.tomorrow.strftime("%Y-%m-%d")    
  end

  def new
    @order = Order.new
    @order.court_book_record = CourtBookRecord.new(params[:court_book_record])
    @order.court_book_record.resource_type = 'Court'
    render :layout => "small_main"
  end

  def create
    @order = Order.new(params[:order])
  end
end
