require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = contacts(:one)
    NEW_EMAIL = "new_email@new_email.com"
  end

  test "visiting contact list" do
    visit contacts_url
    assert_selector "h2", text: "My Contacts"
  end

  test "creating a contact" do
    visit contacts_url
    first(:css, ".fa-user-plus").click

    fill_in "Email*", with: NEW_EMAIL
    fill_in "First Name*", with: @contact.first_name
    fill_in "Last Name*", with: @contact.last_name
    fill_in "Phone Number*", with: @contact.phone
    first(:css, ".fa-save").click

    assert_text "Contact was successfully created"
    first(:css, ".fa-arrow-circle-left").click
  end

  test "updating a contact" do
    visit contacts_url
    first(:css, ".fa-edit").click

    fill_in "Email*", with: NEW_EMAIL
    fill_in "First Name*", with: @contact.first_name
    fill_in "Last Name*", with: @contact.last_name
    fill_in "Phone Number*", with: @contact.phone
    first(:css, ".fa-save").click

    assert_text "Contact was successfully updated"
    first(:css, ".fa-arrow-circle-left").click
  end

  test "destroying a contact" do
    visit contacts_url
    page.accept_confirm do
      first(:css, ".fa-trash").click
    end

    assert_text "Contact was successfully destroyed"
  end

  test "visualizing a contact" do
    visit contacts_url
    first(:css, ".fa-eye").click

    assert_selector ".fa-user-circle"
    first(:css, ".fa-arrow-circle-left").click
  end

  test "visualizing history" do
    visit contacts_url
    first(:css, ".fa-history").click

    assert_selector "h2", text: "My History"
  end

  test "visiting homepage by clicking on header logo" do
    visit contacts_url
    first(:css, ".fa-user-plus").click

    first(:css, ".navbar-brand").click
    assert_selector "h2", text: "My Contacts"
  end
end
