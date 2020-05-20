class Api::V1::RevenueController < ApplicationController
  def index
    render json: Revenue.revenue_across_dates(revenue_params[:start], revenue_params[:end])
  end

  private

  def revenue_params
    params.permit(:start, :end)
  end
end
