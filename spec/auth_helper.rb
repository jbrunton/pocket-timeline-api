RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(GoogleIDToken::Validator)
        .to receive(:check)
            .with('test-user-id-token', nil)
            .and_return({ 'sub' => 'test-user-google-id', 'name' => 'Test User'})
  end
end
