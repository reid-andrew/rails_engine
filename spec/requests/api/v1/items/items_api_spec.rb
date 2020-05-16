require 'rails_helper'

RSpec.describe "Items API - ", type: :request do
  it "shows items index" do
    create_list(:item, 3)

    get '/api/v1/items'
    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end
end
