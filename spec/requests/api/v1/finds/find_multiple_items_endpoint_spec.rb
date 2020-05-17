require 'rails_helper'

RSpec.describe 'Find API Endpoints - ', type: :request do
  before (:each) do
    @merchant = create(:merchant)
  end
  it 'finds multiple items by name' do
    create_list(:item, 3)
    expected_1 = Item.create(name: "Widget",
                             description: Faker::Movies::PrincessBride.quote,
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_2 = Item.create(name: "Widget",
                             description: Faker::Movies::PrincessBride.quote,
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_3 = Item.create(name: "Widget",
                             description: Faker::Movies::PrincessBride.quote,
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find_all?name=widget'
    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].size).to eq(3)
    expect(items["data"][0]["id"]).to eq(expected_1.id.to_s)
    expect(items["data"][1]["id"]).to eq(expected_2.id.to_s)
    expect(items["data"][2]["id"]).to eq(expected_3.id.to_s)
    expect(items["data"][0]["attributes"]["description"]).to eq(expected_1.description)
    expect(items["data"][1]["attributes"]["description"]).to eq(expected_2.description)
    expect(items["data"][2]["attributes"]["description"]).to eq(expected_3.description)
  end
end
