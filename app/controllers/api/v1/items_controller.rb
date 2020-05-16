class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(item_params[:id])
  end

  private

  def item_params
    params.permit(:id)
  end
end
