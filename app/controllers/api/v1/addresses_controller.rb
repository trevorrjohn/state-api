module Api
  module V1
    class AddressesController < ApplicationController
      before_action :validate_query_params!, only: :index
      def index
        addresses = Address
          .where(country: params[:country].upcase.strip)
          .where(state: params[:state].upcase.strip)
          .limit(100)
        render status: :ok, json: addresses.as_json
      end

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

      def validate_query_params!
        country = params[:country]&.strip
        state = params[:state]&.strip
        return if country.present? && state.present?

        render status: :unprocessable_entity, json: {
          errors: ["Country and state must be provided as query params"]
        }
      end
    end
  end
end
