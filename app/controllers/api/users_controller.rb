class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user!
  before_action :set_user

  def show
    json = @user.as_json.tap do |user_json|
      user_json[:posts_count] = @user.posts.count
      user_json[:followers_count] = @user.follows_from_others.count
      user_json[:followings_count] = @user.follows_from_me.count
    end
    render json: json
  end

  def posts
    render json: @user.posts.map { |page| page.to_builder(user: current_user).attributes! }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
