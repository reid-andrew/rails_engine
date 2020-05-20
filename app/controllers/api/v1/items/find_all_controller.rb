class Api::V1::Items::FindAllController < ApplicationController
  def index
    items = FinderFilter.call(Item.all, find_params)
    render json: ItemSerializer.new(items)
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
