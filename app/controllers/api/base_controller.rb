class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!

  rescue_from Exception, with: :render_error
  rescue_from ActionView::MissingTemplate, with: :render_not_found

  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  # routes.rbで使用
  def routing_error
    fail ActionController::RoutingError, params[:path]
  end

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    render json: { error: '404 error' }, status: 404
  end

  def render_500(e = nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e
    render json: { error: '500 error' }, status: 500
  end

  def render_success(message = '')
    @_success = true
    render(
      json: { success: true, message: message },
      status: 200,
    )
  end

  def render_error(error = '', options = {})
    message = case error
              when Exception
                error.message
              when Array
                error.to_json
              when Hash
                error[:message]
              else
                error
              end

    status = options[:status] || :internal_server_error
    render(
      json: { errors: message },
      status: status,
    )
  end

  def render_not_found(_e = nil)
    render(
      json: { message: 'not found' },
      status: :not_found,
    )
  end
end
