class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: Item.where("merchant_id = #{merchant_item_params[:merchant_id]}")
  end

  def merchant_item_params
    params.permit(:merchant_id)
  end

end
