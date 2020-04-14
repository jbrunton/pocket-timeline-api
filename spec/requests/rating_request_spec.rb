require 'rails_helper'

RSpec.describe "Ratings", type: :request do

  describe "GET /score" do
    it "returns http success" do
      get "/rating/score"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /ratings" do
    it "returns http success" do
      get "/rating/ratings"
      expect(response).to have_http_status(:success)
    end
  end

end
