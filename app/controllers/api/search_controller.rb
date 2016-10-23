class Api::SearchController < Api::BaseController
  skip_before_action :authenticate_user!

  def index
    text = params[:text]
    render json: {
      users: User.search(text),
      tags: [],
      spots: [],
    }
  end
end
