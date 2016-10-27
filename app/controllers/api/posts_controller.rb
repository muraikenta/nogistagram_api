class Api::PostsController < Api::BaseController
  def index
    user = User.find(params[:user_id])
    render json: user.posts.map { |page| page.to_builder(user: current_user).attributes! }
  end

  def timeline
    posts = current_user.timeline_posts
    render json: posts.map { |page| page.to_builder(user: current_user).attributes! }
  end

  def create
    post = current_user.posts.build(post_params)
    post.set_image(params[:image_binary])
    if post.save
      render json: post
    else
      render_error post.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:body)
  end
end
