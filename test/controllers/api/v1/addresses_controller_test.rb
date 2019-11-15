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
    end
  end
end
