require "test_helper"

class HistoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:one)
    @contact = contacts(:one)
    NEW_EMAIL = "new_email@new_email.com"
  end

  test "should get history" do
    get "/history"
    assert_response :success
  end

  test "on create contact should create history registration" do
    assert_difference('History.count') do
      post contacts_url, params: { contact: { email: NEW_EMAIL, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    end
  end

  test "on update contact should create history registration" do
    assert_difference('History.count') do
      patch contact_url(@contact), params: { contact: { email: @contact.email, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    end
  end

  test "on destroy contact should create history registration" do
    assert_difference('History.count') do
      delete contact_url(@contact)
    end
  end
end
