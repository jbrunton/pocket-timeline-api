require 'rails_helper'

RSpec.describe "Categories", type: :request do

  describe "GET /show" do
    it "returns http success" do
      timeline = Timeline.create(title: 'Test Timeline')
      category = Category.create(name: 'Test Category', timeline: timeline)

      get "/categories/#{category.id}"

      expect(response).to have_http_status(:success)
    end
  end

end
