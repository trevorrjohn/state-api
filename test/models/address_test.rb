require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "saving country and state are stripped and upcased" do
    state_validator = Minitest::Mock.new
    state_validator.expect(:valid?, true)
    stub = lambda { |args|
      assert_equal "CO", args[:state]
      assert_equal "USA", args[:country]
      state_validator
    }
    StateValidator.stub(:new, stub) do
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
    state_validator.verify
  end

  test "fails validation when state validator returns false" do
    state_validator = Minitest::Mock.new
    state_validator.expect(:valid?, false)
    state_validator.expect(:error, "State not valid for country")
    stub = lambda { |args|
      assert_equal "CO", args[:state]
      assert_equal "POL", args[:country]
      state_validator
    }
    StateValidator.stub(:new, stub) do
      subject = Address.create(
        name: "Work",
        street: "123 Foobar",
        city: "Denver",
        state: " co  ",
        country:  "pol "
      )
      assert_not subject.persisted?
      assert_equal ["State not valid for country"], subject.errors.full_messages
    end
    state_validator.verify
  end
end
