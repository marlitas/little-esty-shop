class ItemsController < ApplicationController

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/items/#{@item.id}", notice: "Item Successfully Updated!"
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
