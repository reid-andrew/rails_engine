class Api::V1::Items::MerchantController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.find(Item.find(item_merchant_params[:item_id]).merchant_id)).serialized_json
  end

  private

  def item_merchant_params
    params.permit(:item_id)
  end
end
