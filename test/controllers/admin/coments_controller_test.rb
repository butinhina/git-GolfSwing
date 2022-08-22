require "test_helper"

class Admin::ComentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_coments_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_coments_destroy_url
    assert_response :success
  end
end
