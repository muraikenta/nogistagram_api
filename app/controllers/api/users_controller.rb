class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user!
  before_action :set_user

  def posts
    render json: @user.posts.map { |page| page.to_builder(user: current_user).attributes! }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
