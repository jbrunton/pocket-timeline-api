class SessionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    authorize(request.env['omniauth.auth'])
  end

  def signin
    authorize(validate_id_token)
  end

  def destroy
    self.current_user = nil
    redirect_to '/home/index', notice: "Signed out!"
  end

  private

  def validate_id_token
    validator = GoogleIDToken::Validator.new
    jwt = validator.check(params['id_token'], ENV['GOOGLE_CLIENT_ID'])
    {
        'uid' => jwt['sub'],
        'provider' => 'google_oauth2'
    }
  end

  def authorize(auth_hash)
    @auth = Authorization.find_from_hash(auth_hash)

    # Create a new user or add an auth to existing user, depending on
    # whether there is already a user signed in.
    @auth = Authorization.create_from_hash(auth_hash, current_user) unless @auth

    # Log the authorizing user in.
    self.current_user = @auth.user

    respond_to do |format|
      format.html { redirect_to '/home/index' }
      format.json { render json: { success: true } }
    end
  end
end
