class RatingController < ApplicationController
  before_action :authenticate_user!

  def score
    rating = current_user.ratings.build(
        normalized_score: params[:normalized_score],
        timeline_id: params[:timeline_id]
    )
    if rating.save
      render json: rating
    else
      render status: :unprocessable_entity, json: { errors: rating.errors }
    end
  end
end
