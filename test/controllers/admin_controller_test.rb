require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_dashboard_url
    assert_response :success
  end

  test "should get approve_loan" do
    get admin_approve_loan_url
    assert_response :success
  end

  test "should get reject_loan" do
    get admin_reject_loan_url
    assert_response :success
  end

  test "should get adjust_loan" do
    get admin_adjust_loan_url
    assert_response :success
  end

  test "should get handle_readjustment_request" do
    get admin_handle_readjustment_request_url
    assert_response :success
  end
end
