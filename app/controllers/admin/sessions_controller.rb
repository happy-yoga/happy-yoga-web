class Admin::SessionsController < ::Admin::ApplicationController
  skip_before_action :reject_unauthenticated

  def new
    session[:user_id] = User.dummy_user.id unless Rails.env.production?
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.valid?
      session[:user_id] = user.id
      redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
