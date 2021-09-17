class Api::V1::AuthenticationController < ApplicationController
  class AuthenticationError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_anauthenticated

  def create
    user = User.find_by(username: params.require(:username))
    raise AuthenticationError unless user.authenticate(params.require(:password))
    token = AuthenticationTokenService.call(user.id)

    render json: { status: true, token: token }, status: :created
  end

  private

  def parameter_missing(e)
    render json: { status: falas, message: e.message }, status: :unprocessable_entity
  end

  def handle_anauthenticated
      head :unauthorized
  end
  
end
