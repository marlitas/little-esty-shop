class ItemsController < ApplicationController

  def update
    @item = Item.find(params[:id])
    # require "pry"; binding.pry
    @item.update(item_params)

    redirect_to "/merchants/#{@item.merchant_id}/items/#{@item.id}"
  end

  #private makes it so that this method cannot be called by other classes.
  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
