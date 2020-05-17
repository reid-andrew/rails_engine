class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all).serialized_json
  end

  def show
    render json: ItemSerializer.new(Item.find(item_params[:id])).serialized_json
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)).serialized_json
  end

  def update
    item = Item.find(item_params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def destroy
    item = Item.find(item_params[:id])
    Item.delete(item)
    render json: ItemSerializer.new(item).serialized_json
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
