class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  rescue_from Exception, with: :render_error
  rescue_from ActionView::MissingTemplate, with: :render_not_found

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
