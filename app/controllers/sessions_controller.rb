class SessionsController < ApplicationController
  def create
    user = Expert.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if request.env['omniauth.origin'] =~ /\/login/
      redirect_to root_path
    else
      redirect_to request.env['omniauth.origin'] || root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
