class Api::V1::Items::MerchantController < ApplicationController

  def index
    render json: Merchant.find(Item.find(item_merchant_params[:item_id]).merchant_id)
  end

  private

  def item_merchant_params
    params.permit(:item_id)
  end

end
