require 'rails_helper'

RSpec.describe SessionsController do
  describe 'GET signin' do
    it "validates the token" do
      request.headers["Content-Type"] = "application/json"
      request.headers["Accept"] = "application/json"
      allow(ENV).to receive(:[]).with("GOOGLE_CLIENT_ID").and_return("a1b2c3")
      allow_any_instance_of(GoogleIDToken::Validator)
          .to receive(:check)
          .with('test-user-id-token', 'a1b2c3')
          .and_return({ 'sub' => 'test-user-google-id', 'name' => 'Test User'})

      get :signin, params: { id_token: 'test-user-id-token'}

      expect(response.body).to eq({ success: true }.to_json)
    end

    it "requires a client id" do
      request.headers["Content-Type"] = "application/json"
      request.headers["Accept"] = "application/json"
      allow_any_instance_of(GoogleIDToken::Validator)
          .to receive(:check)
                  .with('test-user-id-token', 'a1b2c3')
                  .and_return({ 'sub' => 'test-user-google-id', 'name' => 'Test User'})

      expect {
        get :signin, params: { id_token: 'test-user-id-token'}
      }.to raise_error(RuntimeError, "GOOGLE_CLIENT_ID required")
    end
  end
end
