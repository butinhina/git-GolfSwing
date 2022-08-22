require "test_helper"

class Admin::InfomationsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_infomations_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_infomations_update_url
    assert_response :success
  end
end
