class Api::V1::Items::FindController < ApplicationController
  def index
    item = FinderFilter.call(Item.all, find_params).first
    render json: ItemSerializer.new(item)
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
