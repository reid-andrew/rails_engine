require 'rails_helper'

RSpec.describe 'Item/Merchant Relationships API Endpoints - ', type: :request do
  it 'returns the merchant associated with an item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['id']).to eq(item.merchant_id)
  end
end
