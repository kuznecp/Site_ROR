# frozen_string_literal: true

# class SessionsController
class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      redirect_to login_path, notice: 'Invalid Username or Password'
    end
  end

  def destroy
    session[:users_id] = nil
    redirect_to login_path, notice: 'Successfully logged out'
  end
end
