class TimelineController < ApplicationController
  def index
    @timelines = Timeline.includes(:categories).all
    @ratings = Rating.aggregate(current_user) unless current_user.nil?
  end

  def show
    timeline = Timeline.includes(:events).find(params[:id])
    render json: timeline.to_json(include: [:events, :categories])
  end

  helper_method :ratings_for

  private

  def ratings_for(timeline)
    return nil if @ratings.nil?
    @ratings[timeline.id]
  end
end
