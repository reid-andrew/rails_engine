class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serialized_json
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(merchant_params[:id])).serialized_json
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params)).serialized_json
  end

  def update
    merchant = Merchant.find(merchant_params[:id])
    merchant.update(merchant_params)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  def destroy
    merchant = Merchant.find(merchant_params[:id])
    Merchant.delete(merchant)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end
