require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "saving country and state are stripped and upcased" do
    subject = Address.create!(
      name: "Work",
      street: "123 Foobar",
      city: "Denver",
      state: " co  ",
      country:  "usa "
    )
    assert_equal "CO", subject.state
    assert_equal "USA", subject.country
  end
end
