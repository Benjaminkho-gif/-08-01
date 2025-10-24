class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart
  before_action :search

  def search
    @q = Book.ransack(params[:q])
    @book = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end


  def after_sign_in_path_for(resource)
      mypage_path(resource)
  end

  def after_sign_out_path_for(resource)
      root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def current_cart
    @current_cart ||= Cart.find_or_create_by(session_id: session.id.to_s)
  end

end