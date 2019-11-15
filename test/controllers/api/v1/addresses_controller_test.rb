require "test_helper"

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
        state_validator = Minitest::Mock.new
        state_validator.expect(:valid?, true)
        StateValidator.stub(:new, state_validator) do
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
        state_validator.verify
      end

      test "bad address is not created" do
        state_validator = Minitest::Mock.new
        state_validator.expect(:valid?, true)
        StateValidator.stub(:new, state_validator) do
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
        state_validator.verify
      end

      test "updating a valid address" do
        address = addresses(:one)
        body = {
          address: {
            name: "New Name"
          }
        }

        put api_v1_address_url(address, params: body)

        assert_response :ok
        assert_equal address.reload.as_json, JSON.parse(@response.body)
        assert_equal "New Name", address.name
      end

      test "updating with invalid params does not update address" do
        address = addresses(:one)
        body = {
          address: {
            name: ""
          }
        }

        put api_v1_address_url(address, params: body)

        assert_response :unprocessable_entity
        errors = { errors: ["Name can't be blank"] }
        assert_equal errors.to_json, @response.body
        assert_not_equal "", address.reload.name
      end

      test "getting addresses by country and state" do
        home, work = addresses(:one, :two)

        get api_v1_addresses_url(params: { country: "USA", state: "NY" })

        assert_response :ok
        json = JSON.parse(@response.body)
        assert_equal 2, json.size
        assert_empty json.map { |x| x["id"] } - [home.id, work.id]
      end
    end
  end
end
