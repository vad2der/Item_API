require 'test_helper'

class SellersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seller = sellers(:one)
  end

  test "should get index" do
    get sellers_url, as: :json
    assert_response :success
  end

  test "should create seller" do
    assert_difference('Seller.count') do
      post sellers_url, params: { seller: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show seller" do
    get seller_url(@seller), as: :json
    assert_response :success
  end

  test "should update seller" do
    patch seller_url(@seller), params: { seller: {  } }, as: :json
    assert_response 200
  end

  test "should destroy seller" do
    assert_difference('Seller.count', -1) do
      delete seller_url(@seller), as: :json
    end

    assert_response 204
  end
end
