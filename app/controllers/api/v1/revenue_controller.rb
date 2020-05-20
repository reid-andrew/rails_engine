class Api::V1::RevenueController < ApplicationController
  def index
    @revenue = Revenue.revenue_across_dates(revenue_params[:start], revenue_params[:end])
    render '/revenue/index.json'
  end

  private

  def revenue_params
    params.permit(:start, :end)
  end
end
