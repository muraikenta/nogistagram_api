class Api::PostsController < Api::BaseController
  before_action :authenticate_user!

  def index
    if current_user
      # TODO: 友達のpostsも含める
      posts = current_user.posts
      render json: posts
    else
      render_not_found
    end
  end
end
