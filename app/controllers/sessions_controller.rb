class SessionsController < ApplicationController
  before_filter :authenticate_user, except: [:index, :login, :logout, :authorize_user]
  before_filter :save_login_state, only: [:index, :login, :authorize_user]

  def login
  end

  def authorize_user
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      redirect_to message_thread_index_path
    else
      flash[:notice] = 'Invalid Username or Password'
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'You have been logged out'
    redirect_to login_path
  end
end
