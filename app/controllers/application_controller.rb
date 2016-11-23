# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :learn_with_geekhub

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password)
    end
  end

  def learn_with_geekhub
    if cookies[:pageLoads]
      cookies[:pageLoads] = cookies[:pageLoads].to_i + 1
    else
      cookies[:pageLoads] = 0
    end

    if cookies[:pageLoads] == 10
      flash.now[:notice] = "Учитесь вместе с GeekHub -______-"
      cookies[:pageLoads] = 0
    end
  end
end
