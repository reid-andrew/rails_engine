require 'rails_helper'

RSpec.describe 'Find Multiple Items API Endpoint - ', type: :request do
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

  it 'finds multiple items by description' do
    create_list(:item, 3)
    expected_1 = Item.create(name: Faker::Appliance.unique.equipment,
                             description: "I'm not working for the clampdown",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_2 = Item.create(name: Faker::Appliance.unique.equipment,
                             description: "I'll be working all day for me mates",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_3 = Item.create(name: Faker::Appliance.unique.equipment,
                             description: "Working on a dream",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find_all?description=working'
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

  it 'finds multiple items by multiple criteria' do
    create_list(:item, 3)
    expected_1 = Item.create(name: "Widget",
                             description: "I'm not working for the clampdown",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_2 = Item.create(name: "Gadget",
                             description: "I'll be working all day for me mates",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)
    expected_3 = Item.create(name: "Sledgehammer",
                             description: "Working on a dream",
                             unit_price: Faker::Number.positive,
                             merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find_all?name=dge&description=working'
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

  it 'handles no results provided' do
    Item.create(name: "Widget",
                description: "Widgets of the world unite!",
                unit_price: Faker::Number.positive,
                merchant_id: @merchant.id)

    get '/api/v1/items/find_all?name=nope'
    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"]).to eq([])
  end
end
