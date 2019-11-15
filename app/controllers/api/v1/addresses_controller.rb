module Api
  module V1
    class AddressesController < ApplicationController

      def destroy
        address = Address.find(params[:id])
        address.destroy
        render :ok
      end
    end
  end
end
