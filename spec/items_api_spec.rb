require 'rails_helper'
require 'airborne'

RSpec.describe 'Items API test' do
  describe 'GET items' do
    it 'returns correct types' do
      get '/api/v1/items', :format => 'json'
      expect_json_types(name: :string)
    end

 	it 'should validate values' do
    	get '/api/v1/items/1'
    	expect_json(title: 'Item 1')
  	end

  	it 'should validate rout output' do
    	get '/api/v1/item_by_category/Clothing'
    	expect_json(title: :string)
  	end

  end
end