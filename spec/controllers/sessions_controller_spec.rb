require 'rails_helper'

RSpec.describe SessionsController do
  describe 'GET signin' do
    it "validates the token" do
      request.headers["Content-Type"] = "application/json"
      request.headers["Accept"] = "application/json"
      allow_any_instance_of(GoogleIDToken::Validator)
          .to receive(:check)
          .with('test-user-id-token', nil)
          .and_return({ 'sub' => 'test-user-google-id', 'name' => 'Test User'})

      get :signin, params: { id_token: 'test-user-id-token'}

      expect(response.body).to eq({ success: true }.to_json)
    end
  end
end
