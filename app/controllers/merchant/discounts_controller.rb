class Merchant::DiscountsController < ApplicationController
  def upcoming_holidays
    json = NagerService.new.get_holiday
    holidays = json.map do |holiday|
      Holiday.new(holiday)
    end.find_all do |holiday|
      holiday.date > Time.now
    end.min_by(3) do |holiday|
      holiday.date
    end
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = upcoming_holidays
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = Discount.new(percent: params[:discount][:percent], quantity_threshold: params[:discount][:quantity_threshold], merchant_id: params[:merchant_id])
    if discount.save
      redirect_to "/merchants/#{params[:merchant_id]}/discounts"
    else
      flash[:notice] = 'Discount not created: Required information missing'
      redirect_to "/merchants/#{params[:merchant_id]}/discounts/new"
    end
  end

  def update
    discount = Discount.find(params[:id])
    discount.update!(percent: params[:discount][:percent], quantity_threshold: params[:discount][:quantity_threshold])

    redirect_to "/merchants/#{discount.merchant_id}/discounts/#{discount.id}"
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end
end
