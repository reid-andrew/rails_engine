class Api::V1::Items::FindController < ApplicationController

  def index
    item = Item.all
    item = SingleFinderFilter.call(item, find_params)
    render json: ItemSerializer.new(item)
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
