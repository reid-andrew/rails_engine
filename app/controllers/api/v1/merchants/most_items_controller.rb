class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    merchants = Merchant.most_items(most_items_params[:quantity])
    render json: MerchantSerializer.new(merchants, { params: { items: true }})
  end

  private

  def most_items_params
    params.permit(:quantity)
  end
end
