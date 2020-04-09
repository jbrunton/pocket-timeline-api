class UserController < ApplicationController
  before_action :authenticate_user!

  def profile
    respond_to do |format|
      format.html
      format.json { render json: current_user.as_json }
    end
  end
end
