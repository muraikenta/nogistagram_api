class Api::PostsController < Api::BaseController
  def index
    posts = current_user.timeline_posts
    render json: posts
  end
end
