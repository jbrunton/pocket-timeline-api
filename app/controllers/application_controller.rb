class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def authenticate_user!
    if current_user.nil?
      respond_to do |format|
        format.html do
          session['auth.origin'] = request.fullpath
          redirect_to '/auth/google_oauth2'
        end
        format.json { head :unauthorized }
      end
    end
  end

  helper_method :current_user, :signed_in?, :authenticate_user!

  def current_user=(user)
    @current_user = user
    session[:user_id] = user&.id
  end
end
