class Api::OmniauthController < Api::BaseController
  skip_before_action :authenticate_user!

  def sign_in
    user = User.find_by(omniauth_signin_params)
    if user
      new_auth_header = user.create_new_auth_token
      response.headers.merge!(new_auth_header)
      render json: user
    else
      render_not_found
    end
  end

  def create
    user = User.new(omniauth_params)
    user.set_data_for_facebook
    if user.save
      new_auth_header = user.create_new_auth_token
      response.headers.merge!(new_auth_header)
      render json: user
    else
      render_error user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def omniauth_signin_params
    params.permit(:provider, :uid, :email)
  end

  def omniauth_params
    params.permit(:uid, :name, :email, :unique_name, :provider, :omniauth_token)
  end
end
