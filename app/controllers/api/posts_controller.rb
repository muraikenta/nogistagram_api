class Api::PostsController < Api::BaseController
  before_action :set_post, only: [:destroy]
  before_action :ensure_correct_user!, only: [:destroy]

  def timeline
    posts = current_user.timeline_posts
    render json: posts.map { |post| post.to_builder(user: current_user).attributes! }
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

  def destroy
    @post.destroy
    render json: { id: params[:id] }
  end

  private

  def post_params
    params.permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_correct_user!
    unless @post.user_id == current_user.id
      render_error 'Not Allowed', status: :forbidden
    end
  end
end
