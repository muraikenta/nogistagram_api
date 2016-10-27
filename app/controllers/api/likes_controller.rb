class Api::LikesController < Api::BaseController
  before_action :set_post

  def create
    like = current_user.likes.build(post: @post)
    if like.save
      render json: @post.to_builder(user: current_user).attributes!
    else
      render_error @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    like = current_user.likes.find_by(post: @post)
    like.destroy
    render json: @post.to_builder(user: current_user).attributes!
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
