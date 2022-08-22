require "test_helper"

class Admin::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show,edit" do
    get admin_customers_show,edit_url
    assert_response :success
  end
end
