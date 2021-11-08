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

  test "can not save contact if empty first name" do
    @contact = Contact.new(first_name: "", last_name: LAST_NAME, email: EMAIL, phone: PHONE)
    assert !@contact.valid? 
    assert !@contact.save()
  end

  test "can not save contact if empty last name" do
    @contact = Contact.new(first_name: FIRST_NAME, last_name: "", email: EMAIL, phone: PHONE)
    assert !@contact.valid? 
    assert !@contact.save()
  end

  test "can not save contact if empty email" do
    @contact = Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: "", phone: PHONE)
    assert !@contact.valid? 
    assert !@contact.save()
  end

  test "can not save contact if empty phone number" do
    @contact = Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: "")
    assert !@contact.valid? 
    assert !@contact.save()
  end

  test "can not save contact if repeated email" do
    assert @contact.save()
    @contact = Contact.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: PHONE)
    assert !@contact.valid?
    assert !@contact.save()
  end

  test "can update contact when keeping email" do
    @contact.save()
    assert @contact.update(email: EMAIL)
    assert_equal(Contact.find_by(id: @contact.id).email, EMAIL)
  end
end
