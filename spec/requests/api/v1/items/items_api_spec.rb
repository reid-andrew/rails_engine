require 'rails_helper'

RSpec.describe 'Items API - ', type: :request do
  it 'returns items index' do
    create_list(:item, 3)

    get '/api/v1/items'
    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it 'returns items show record' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it 'creates item record' do
    merchant = create(:merchant)
    params = {name: Faker::Appliance.unique.equipment,
              description: Faker::Movies::PrincessBride.quote,
              unit_price: Faker::Number.positive,
              merchant_id: merchant.id}

    post "/api/v1/items", params: params
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(params[:name])
  end
end
