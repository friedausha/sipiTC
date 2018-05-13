class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def ping
    head :ok
  end

  def health
    head :ok
  end

  def route_not_found
    render json: [], status: :not_found
  end

  private

  def record_not_found(exception)
    render json: [], status: :not_found
  end

  def internal_server_error(exception)
    render json: [], status: :internal_server_error
  end
end
