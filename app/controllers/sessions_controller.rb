class SessionsController < ApplicationController
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
    client_id = ENV['GOOGLE_CLIENT_ID']
    if client_id.nil?
      raise RuntimeError, "GOOGLE_CLIENT_ID required"
    end
    jwt = validator.check(params['id_token'], client_id)
    {
        'uid' => jwt['sub'],
        'provider' => 'google_oauth2',
        'info' => {
            'name' => jwt['name']
        }
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
      format.html { redirect_to pop_auth_origin || '/home/index' }
      format.json { render json: { success: true } }
    end
  end

  private

  def pop_auth_origin
    auth_origin = session['auth.origin']
    session['auth.origin'] = nil
    auth_origin
  end
end
