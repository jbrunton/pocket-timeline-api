class TimelineController < ApplicationController
  def index
    @timelines = Timeline.all
    @ratings = Rating.aggregate(current_user) unless current_user.nil?
  end

  def show
    timeline = Timeline.includes(:events).find(params[:id])
    render json: timeline.to_json(include: :events)
  end

  helper_method :normalized_score_for

  private

  def normalized_score_for(timeline)
    return nil if @ratings.nil?
    rating = @ratings[timeline.id] || {}
    rating[:normalized_score]
  end
end
