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
    Discount.create!(percent: params[:discount][:percent], quantity_threshold: params[:discount][:quantity_threshold], merchant_id: params[:merchant_id])

    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
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

  def discount_params
    params.permit( :merchant_id)
  end
end
