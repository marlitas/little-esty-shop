class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.create!(name: params[:name], description: params[:description], unit_price: params[:unit_price], merchant_id: params[:merchant_id])
    redirect_to "/merchants/#{@merchant.id}/items", notice: "Item Successfully Created!"
  end

  def update
    item = Item.find(params[:id])
    merchant = Merchant.find(item.merchant_id)
    if params[:status].present?
      item.update!(status: params[:status].to_i)
    end
    redirect_to "/merchants/#{merchant.id}/items"
  end
end
