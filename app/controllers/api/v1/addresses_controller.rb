module Api
  module V1
    class AddressesController < ApplicationController
      def create
        address = Address.create(address_params)
        if address.persisted?
          render status: :created, json: address.as_json
        else
          render status: :unprocessable_entity, json: {
            errors: address.errors.full_messages
          }
        end
      end

      def update
        address = Address.find(params[:id])

        if address.update(address_params)
          render status: :ok, json: address.as_json
        else
          render status: :unprocessable_entity, json: {
            errors: address.errors.full_messages
          }
        end
      end

      def destroy
        address = Address.find(params[:id])
        address.destroy
        render status: :ok
      end

      private

      def address_params
        params.require(:address).permit(:name, :street, :city, :state, :country)
      end
    end
  end
end
