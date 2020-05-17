class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    merchants = Merchant.all
    merchants = FinderFilter.call(merchants, find_params)
    render json: MerchantSerializer.new(merchants)
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
