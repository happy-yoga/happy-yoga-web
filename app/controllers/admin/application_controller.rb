class Admin::ApplicationController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :reject_unauthenticated
  helper_method :current_user

  layout 'admin_layout'

  private

  def find_user(user_id)
    Rails.env.production? ? User.find(session[:user_id]) : User.dummy_user
  end


  def current_user
    session[:user_id].nil? ? nil : find_user(session[:user_id])
  end

  def admin?
    current_user.admin?
  end

  def reject_unauthenticated
    redirect_to admin_sessions_new_path unless (current_user && admin?)
  end
end
