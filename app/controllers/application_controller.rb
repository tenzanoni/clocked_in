class ApplicationController < ActionController::API
  # rescue_from Exception, with: :server_error
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def current_user
    return User.find(params[:assign_user_id]) if params[:assign_user_id].present? #in case want to create time track for a specific user
    User.first
  end

  def server_error
    render status: 500, json: { status: 500, errors: { message: 'Internal Server Error' } }
    return
  end

  def render_404
    render status: 404, json: { status: 404, errors: { message: 'Not Found' } }
    return
  end
end
