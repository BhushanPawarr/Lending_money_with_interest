require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get request_loan" do
    get users_request_loan_url
    assert_response :success
  end

  test "should get accept_loan" do
    get users_accept_loan_url
    assert_response :success
  end

  test "should get reject_loan" do
    get users_reject_loan_url
    assert_response :success
  end

  test "should get repay_loan" do
    get users_repay_loan_url
    assert_response :success
  end
end
