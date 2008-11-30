# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7dddbd00f8f611d64c5b2d542ca45eb5'
  
protected

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def login_required
    unless logged_in?
      flash[:error] = 'Sign in with your OpenID'
      redirect_to login_url
    end
  end

end
