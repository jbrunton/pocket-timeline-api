class TimelineController < ApplicationController
  def index
    render json: Timeline.all
  end

  def show
    timeline = Timeline.includes(:events).find(params[:id])
    render json: timeline.to_json(include: :events)
  end
end
