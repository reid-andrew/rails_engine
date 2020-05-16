class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(merchant_params[:id])
  end

  def create
    render json: Merchant.create(merchant_params)
  end

  def update
    render json: Merchant.find(merchant_params[:id]).update(merchant_params)
  end

  def destroy
    render json: Merchant.delete(merchant_params[:id])
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end
