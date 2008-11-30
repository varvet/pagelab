class SessionsController < ApplicationController

  def new
  end

  def create
    open_id_authentication
  end

protected

  def open_id_authentication
    identity_url = params[:openid_identifier]
    options = {:optional => [:email, :fullname]}
    
    authenticate_with_open_id(identity_url, options) do |result, identity_url, registration|
      if result.successful?
        @current_user = User.find_or_create_by_identity_url(identity_url)
        assign_registration_attributes!(registration)
        
        successful_login
      else
        failed_login result.message
      end
    end
  end

  def assign_registration_attributes! (reg)
    @current_user.name = reg['fullname'] if !@current_user.name? and !reg['fullname'].blank?
    @current_user.name = reg['fullname'] if !@current_user.name? and !reg['fullname'].blank?
    @current_user.save if @current_user.changed?
  end

  def successful_login
    session[:user_id] = @current_user.id
    
    redirect_to root_url
  end

  def failed_login(message)
    flash[:error] = message
    
    redirect_to login_url
  end

end
