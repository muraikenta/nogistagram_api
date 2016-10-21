class Api::SearchController < Api::BaseController
  skip_before_action :authenticate_user!

  def index
    render json: {
      users: User.where('unique_name LIKE ?', "%#{params[:text]}%"),
      tags: [],
      spots: [],
    }
  end
end
