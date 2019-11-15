require 'test_helper'

class StateValidatorTest < ActiveSupport::TestCase
  test "returns success when result in body" do
    mock = Minitest::Mock.new
    mock.expect(:success?, true)
    mock.expect(:body, '{"RestResponse":{"result":{"state":"NY"}}}')

    stub = lambda do |url|
      assert_equal "http://groupkt.com/state/get/USA/NY", url
      mock
    end
    Faraday.stub(:get, stub) do
      subject = StateValidator.new(state: "NY", country: "USA")
      assert subject.valid?
      assert_nil subject.error
    end

    mock.verify
  end

  test "returns failure when no result in body" do
    mock = Minitest::Mock.new
    mock.expect(:success?, true)
    mock.expect(:body, '{"RestResponse":{"messages":["No matching state"]}}')

    stub = lambda do |url|
      assert_equal "http://groupkt.com/state/get/USA/NY", url
      mock
    end
    Faraday.stub(:get, stub) do
      subject = StateValidator.new(state: "NY", country: "USA")
      assert_not subject.valid?
      assert_equal "State not valid for country", subject.error
    end

    mock.verify
  end

  test "returns failure when http request fails" do
    mock = Minitest::Mock.new
    mock.expect(:success?, false)

    stub = lambda do |url|
      assert_equal "http://groupkt.com/state/get/USA/NY", url
      mock
    end
    Faraday.stub(:get, stub) do
      subject = StateValidator.new(state: "NY", country: "USA")
      assert_not subject.valid?
      assert_equal "Could not validate state, please try again", subject.error
    end

    mock.verify
  end
end
