class Api::PostsController < Api::BaseController
  before_action :authenticate_user!

  def index
    if current_user
      posts = current_user.timeline_posts
      render json: posts
    else
      render_not_found
    end
  end
end
