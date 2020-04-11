require 'rails_helper'

RSpec.describe "Timelines", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/timeline/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/timeline/show"
      expect(response).to have_http_status(:success)
    end
  end

end
