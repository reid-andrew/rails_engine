class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where("merchant_id = #{merchant_item_params[:merchant_id]}")).serialized_json
  end

  def merchant_item_params
    params.permit(:merchant_id)
  end
end
