class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_from_auth_hash(request.env["omniauth.auth"])

    if user.valid?
      session[:user_id] = user.id
      redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to request.referer
  end
end
