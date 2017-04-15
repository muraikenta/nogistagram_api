class Api::FollowsController < Api::BaseController
  before_action :set_follow, only: [:find, :destroy]

  def find
    render json: { follow: @follow }
  end

  def create
    follow = Follow.create(
             from_user_id: params[:from_user_id],
             to_user_id: params[:to_user_id]
           )

    render json: { follow: follow }
  end

  def destroy
    @follow.destroy
    render json: { follow: @follow }
  end

  private

  def set_follow
    @follow =
      Follow.find_by(
        from_user_id: params[:from_user_id],
        to_user_id: params[:to_user_id]
      )
  end
end
