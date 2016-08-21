require 'rails_helper'

Capybara.default_driver = :poltergeist

RSpec.describe "API format validation" , :type => :api do 
include Capybara::DSL
  it "making a request" do
    get "/api/v1/items/1",:formate =>:json
    last_response.status.should eql(200)
    error = {:error=>'wrong dormat'}
    last_response.body.should  eql(error.to_json)
  end
end   

RSpec.describe "Routing test", :type => :routing do
include Capybara::DSL

before :all do
 $continue = true
end

around :each do |example|
  if $continue
    $continue = false 
    example.run 
    $continue = true unless example.exception
  else
    example.skip
  end
end

context "List of all items" do
  context "Item has necessary fields" do
    visit ("/api/v1/items")
    expect(page.status_code).to eq(200)
    the_item = Item.where(title: "Item 2").take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end
  end
end
          
context "One item info" do
  context "Item has necessary fields" do
    visit ("/api/v1/items/Item 1")
    expect(page.status_code).to eq(200)
    the_item = Item.where(title: "Item 1").take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end
  end
end
          
context "All sold items of a particular seller" do
  context "Item has necessary fields" do
    visit ("/api/v1/item_be_seller/Seller_1")
    expect(page.status_code).to eq(200)
    seller_id = Seller.where(name: "Seller_1").take.id
    status_id = Status.where(value: "Sold").take.id
    the_item = Item.where(seller_id: seller_id, status_id: status_id).take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end
  end
end
          
context "All available items by a particular category" do
  context "Item has necessary fields" do
           
    visit ("/api/v1/item_be_seller/Car")
    expect(page.status_code).to eq(200)
    category_id = Category.where(value: "Car").take.id
    status_id = Status.where(value: "Available").take.id
    the_item = Item.where(category_id: category_id, status_id: status_id).take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end

    visit ("/api/v1/item_be_seller/Clothing")
    expect(page.status_code).to eq(200)
    category_id = Category.where(value: "Car").take.id
    status_id = Status.where(value: "Available").take.id
    the_item = Item.where(category_id: category_id, status_id: status_id).take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end
    visit ("/api/v1/item_be_seller/Others")
    expect(page.status_code).to eq(200)
    category_id = Category.where(value: "Others").take.id
    status_id = Status.where(value: "Available").take.id
    the_item = Item.where(category_id: category_id, status_id: status_id).take
    the_item.each do |key, val|              
      expect(page).to have_content(val)
    end

 end
end
context "Banned Item does not have some fields" do
   context "Item does not have seller_name and published_date" do
      status_id = Status.where(value: "Banned").take.id
      the_item = Item.where(status_id: status_id).take
      visit ("/api/v1/items/"+the_item.id)
      expect(page.status_code).to eq(200)
      expect(page.has_field?('seller_name')).to be false
      expect(page.has_field?('published_date')).to be false
    end
  end
end