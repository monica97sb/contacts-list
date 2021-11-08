require "test_helper"

class HistoryTest < ActiveSupport::TestCase
  setup do
    FIRST_NAME = "First Name"
    LAST_NAME = "Last name"
    EMAIL = "Email"
    PHONE = "Phone"
    CREATION = "Creation"
    UPDATE = "Update"

    @previous = History.all.count
  end

  test "CRUD" do
    @history = History.new(first_name: FIRST_NAME, last_name: LAST_NAME, email: EMAIL, phone: PHONE, action: CREATION)
    @history.save()
    assert_equal(History.all.count, @previous + 1)

    @history.update(action: UPDATE)
    assert_equal(History.all.count, @previous + 1)
    assert_equal(History.find_by(id: @history.id).action, UPDATE)

    @history.destroy
    assert_equal(History.all.count, @previous)
    assert_equal(History.find_by(id: @history.id), nil)
  end
end
