class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchants = Merchant.most_revenue(most_revenue_params[:quantity])
    render json: MerchantSerializer.new(merchants, { params: { revenue: true }})
  end

  private

  def most_revenue_params
    params.permit(:quantity)
  end
end
