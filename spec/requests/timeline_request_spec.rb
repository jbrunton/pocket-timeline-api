require 'rails_helper'

RSpec.describe "Timelines", type: :request do

  describe "GET /timelines" do
    it "returns http success" do
      get "/timelines.json"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      timeline = Timeline.create(title: 'Test Timeline')
      get "/timelines/#{timeline.id}.json"
      expect(response).to have_http_status(:success)
    end
  end

end
