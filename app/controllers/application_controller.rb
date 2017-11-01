class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_user
    if session[:user_id]
      # set current_user by the current user object
      @current_user = User.find session[:user_id]
      return true
    else
      redirect_to(controller: 'sessions', action: 'login')
      return false
    end
  end

  # This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
      redirect_to(controller: 'message_thread', action: 'index')
      return false
    else
      return true
    end
  end
end
