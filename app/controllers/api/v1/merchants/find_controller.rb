class Api::V1::Merchants::FindController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.where("LOWER(name) LIKE LOWER('%#{find_params[:name]}%')").first).serialized_json
  end

  private

  def find_params
    params.permit(:name, :created_at, :updated_at)
  end
end
