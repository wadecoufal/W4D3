class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :ownered?
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
    # @current_user = user #Reminder: NEVER AGAIN!!!
  end
  
  def logged_in?
    # debugger
    !!current_user
  end
  
  def require_login
    redirect_to new_session_url unless logged_in?
  end
  
  def require_logout
    redirect_to cats_url if logged_in?
  end
  
  def ownered?
    cat = Cat.find(params[:id]) ###To do: link cat with cat owner 
    cat.user_id == current_user.id
  end
  
  def require_ownership
    redirect_to cats_url unless ownered?
  end
end
