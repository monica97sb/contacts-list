require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
    NEW_EMAIL = "newemail@newemail.com"
    EMPTY_STRING = ""
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: { contact: { email: NEW_EMAIL, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { email: @contact.email, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    assert_redirected_to contact_url(Contact.last)
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end

  test "should not create contact if repeated email" do
    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { email: @contact.email, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    end
  end

  test "should not create contact if any empty required field" do
    delete contact_url(@contact)

    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { email: EMPTY_STRING, first_name: @contact.first_name, last_name: @contact.last_name, phone: @contact.phone } }
    end

    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { email: @contact.email, first_name: EMPTY_STRING, last_name: @contact.last_name, phone: @contact.phone } }
    end

    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { email: @contact.email, first_name: @contact.first_name, last_name: EMPTY_STRING, phone: @contact.phone } }
    end

    assert_no_difference('Contact.count') do
      post contacts_url, params: { contact: { email: @contact.email, first_name: @contact.first_name, last_name: @contact.last_name, phone: EMPTY_STRING } }
    end
  end
end
