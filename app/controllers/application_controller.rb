class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    response = { error: "Not Found" }
    render json: response, status: :not_found
  end
end
