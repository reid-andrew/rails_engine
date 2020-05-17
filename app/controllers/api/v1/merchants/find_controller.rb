class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.all
    merchant = SingleFinderFilter.call(merchant, find_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
