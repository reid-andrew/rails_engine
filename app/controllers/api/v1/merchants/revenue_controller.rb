class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchant = Merchant.revenue(revenue_params[:merchant_id])
    render json: MerchantRevenueSerializer.new(merchant)
  end

  private

  def revenue_params
    params.permit(:merchant_id)
  end
end
