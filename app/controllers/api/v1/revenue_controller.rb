class Api::V1::RevenueController < ApplicationController
  def index
    @rev = Revenue.revenue_across_dates(revenue_params[:start], revenue_params[:end])
    render json: RevenueSerializer.new(@rev).serialized_json
  end

  private

  def revenue_params
    params.permit(:start, :end)
  end
end
