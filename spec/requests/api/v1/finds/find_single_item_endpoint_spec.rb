require 'rails_helper'

RSpec.describe 'Find Single Item API Endpoint - ', type: :request do
  before (:each) do
    @merchant = create(:merchant)
  end
  it 'finds a single item by name' do
    create_list(:item, 3)
    expected = Item.create(name: "Widget",
                           description: Faker::Movies::PrincessBride.quote,
                           unit_price: Faker::Number.positive,
                           merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find?name=widget'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

  it 'finds a single item by description' do
    create_list(:item, 3)
    expected = Item.create(name: Faker::Appliance.unique.equipment,
                           description: "Rudie can't fail",
                           unit_price: Faker::Number.positive,
                           merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find?description=rudie'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

  it 'finds a single item by unit price' do
    expected = Item.create(name: Faker::Appliance.unique.equipment,
                           description: Faker::Movies::PrincessBride.quote,
                           unit_price: 14.99,
                           merchant_id: @merchant.id)
    create_list(:item, 5)

    get '/api/v1/items/find?unit_price=14.99'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

  # it 'finds a single item by created date' do
  #   expected = Item.create(name: Faker::Appliance.unique.equipment,
  #                          description: Faker::Movies::PrincessBride.quote,
  #                          unit_price: Faker::Number.positive,
  #                          merchant_id: @merchant.id)
  #   create_list(:item, 5)
  #
  #   get '/api/v1/items/find?created_at=#{Time.zone.now}'
  #   item = JSON.parse(response.body)
  #
  #   expect(response).to be_successful
  #   expect(item["data"]["id"]).to eq(expected.id.to_s)
  #   expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  # end

  it 'returns the first item when multiple items meet the criteria' do
    create_list(:item, 3)
    expected = Item.create(name: "Widget",
                           description: Faker::Movies::PrincessBride.quote,
                           unit_price: Faker::Number.positive,
                           merchant_id: @merchant.id)
    Item.create(name: "Midge",
                description: Faker::Movies::PrincessBride.quote,
                unit_price: Faker::Number.positive,
                merchant_id: @merchant.id)
    create_list(:item, 3)
    Item.create(name: "Gidget",
                description: Faker::Movies::PrincessBride.quote,
                unit_price: Faker::Number.positive,
                merchant_id: @merchant.id)

    get '/api/v1/items/find?name=idg'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

  it 'finds a single item by multiple criteria' do
    create_list(:item, 3)
    expected_1 = Item.create(name: "Widget",
                           description: "Widgets of the world unite!",
                           unit_price: 10.99,
                           merchant_id: @merchant.id)
    expected_2 = Item.create(name: "Widget",
                           description: "Widgets wobble but they never fall down!",
                           unit_price: 5.55,
                           merchant_id: @merchant.id)
    create_list(:item, 3)

    get "/api/v1/items/find?name=widget&unit_price=10.99"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected_1.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected_1.description)

    get "/api/v1/items/find?name=widget&description=of%20the%20world"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected_1.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected_1.description)

    get "/api/v1/items/find?name=widget&description=wobble"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected_2.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected_2.description)
  end

  it 'finds a single item in a case insensitive manner' do
    create_list(:item, 3)
    expected = Item.create(name: "Widget",
                           description: "Widgets of the world unite!",
                           unit_price: Faker::Number.positive,
                           merchant_id: @merchant.id)
    create_list(:item, 3)

    get '/api/v1/items/find?name=iDgE'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(expected.id.to_s)
    expect(item["data"]["attributes"]["description"]).to eq(expected.description)
  end

  it 'handles no results provided' do
    Item.create(name: "Widget",
                description: "Widgets of the world unite!",
                unit_price: Faker::Number.positive,
                merchant_id: @merchant.id)

    get '/api/v1/items/find?name=nope'
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]).to eq(nil)
  end
end
