require 'test_helper'

module Api
  module V1
    class AddressesControllerTest < ActionDispatch::IntegrationTest
      fixtures :addresses

      test "deleting an address" do
        address = addresses(:one)
        delete api_v1_address_url(address)

        assert_response :success
        assert_nil Address.find_by(id: address.id)
      end

      test "cannot delete unknown address" do
        delete api_v1_address_url(SecureRandom.uuid)

        assert_response :not_found
      end

      test "create an address" do
        body = {
          address: {
            name: "Home",
            street: "24 Park Ave",
            city: "New York",
            state: "NY",
            country: "USA"
          }
        }
        post api_v1_addresses_url(params: body)

        assert_response :created
        address = Address.order(:created_at).last
        assert_equal address.to_json, @response.body
      end

      test "bad address is not created" do
        body = {
          address: {
            name: "",
            street: "24 Park Ave",
            city: "New York",
            state: "NY",
            country: "USA"
          }
        }
        post api_v1_addresses_url(params: body)

        assert_response :unprocessable_entity
        errors = { errors: ["Name can't be blank"] }
        assert_equal errors.to_json, @response.body
      end
    end
  end
end
