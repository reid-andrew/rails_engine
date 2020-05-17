require 'rails_helper'

RSpec.describe 'Find API Endpoints - ', type: :request do
  it 'finds a single item by name' do
    create_list(:item, 3)
    merchant = create(:merchant)
    expected = Item.create(name: "Widget",
                           description: Faker::Movies::PrincessBride.quote,
                           unit_price: Faker::Number.positive,
                           merchant_id: merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find?name=widget'
    item = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

end
