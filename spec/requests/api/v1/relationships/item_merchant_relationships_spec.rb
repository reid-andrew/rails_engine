require 'rails_helper'

RSpec.describe 'Item/Merchant Relationship API Endpoints - ', type: :request do
  it 'returns the merchant associated with an item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['id']).to eq(item.merchant_id)
  end

  it 'returns the items associated with a merchant' do
    merchant = create(:merchant)
    create_list(:item, 3)
    Item.create(  params = {name: Faker::Appliance.unique.equipment,
                  description: Faker::Movies::PrincessBride.quote,
                  unit_price: Faker::Number.positive,
                  merchant_id: merchant.id})
    Item.create(  params = {name: Faker::Appliance.unique.equipment,
                  description: Faker::Movies::Lebowski.quote,
                  unit_price: Faker::Number.positive,
                  merchant_id: merchant.id})

    get "/api/v1/merchants/#{merchant.id}/items"
    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items[-1]["name"]).to eq(Item.last.name)
  end
end
