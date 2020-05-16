class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(merchant_params[:id])
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end
