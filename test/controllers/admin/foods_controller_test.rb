require "test_helper"

class Admin::FoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_foods_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_foods_show_url
    assert_response :success
  end
end
