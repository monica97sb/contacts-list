require "test_helper"

class ContactTest < ActiveSupport::TestCase
  setup do
    FIRST_NAME = "First name"
    LAST_NAME = "Last name"
    EMAIL = "Email"
    PHONE = "Phone"
    NEW_EMAIL = "New email"
    @contact = Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: PHONE)
    @previous = Contact.all.count
  end

  test "CRUD" do
    assert @contact.save()
    assert_equal(Contact.all.count, @previous + 1)

    assert @contact.update(email: NEW_EMAIL)
    assert_equal(Contact.all.count, @previous + 1)
    assert_equal(Contact.find_by(id: @contact.id).email, NEW_EMAIL)

    assert@contact.destroy
    assert_equal(Contact.all.count, @previous)
    assert_equal(Contact.find_by(id: @contact.id), nil)
  end

  test "can not save contact if any empty required field" do
    assert_equal(Contact.new(first_name: "", last_name: LAST_NAME, email: EMAIL, phone: PHONE).valid?, false)
    assert_equal(Contact.new(first_name: FIRST_NAME, last_name: "", email: EMAIL, phone: PHONE).valid?, false)
    assert_equal(Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: "", phone: PHONE).valid?, false)
    assert_equal(Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: "").valid?, false)
  end

  test "can not save contact if repeated email" do
    @contact.save()
    @contact = Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: PHONE)
    assert_equal(@contact.valid?, false)
  end

  test "can update contact when keeping email" do
    @contact.save()
    assert_equal(@contact.update(email: EMAIL), true)
    assert_equal(Contact.find_by(id: @contact.id).email, EMAIL)
  end
end
