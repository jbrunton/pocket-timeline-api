class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    @auth = Authorization.find_from_hash(auth_hash)

    # Create a new user or add an auth to existing user, depending on
    # whether there is already a user signed in.
    @auth = Authorization.create_from_hash(auth_hash, current_user) unless @auth

    # Log the authorizing user in.
    self.current_user = @auth.user

    render plain: "Welcome, #{current_user.name}."
  end
end
