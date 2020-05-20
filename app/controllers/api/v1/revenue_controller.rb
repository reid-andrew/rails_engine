class Api::V1::RevenueController < ApplicationController
  def index
    render json: RevenueSerializer.new(Revenue.revenue_across_dates(revenue_params[:start], revenue_params[:end])).serialized_json
  end

  private

  def revenue_params
    params.permit(:start, :end)
  end
end
