Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  #provider :facebook, 'APP_ID', 'APP_SECRET'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  puts "configuring google_oauth2, #{ENV['GOOGLE_CLIENT_ID']}, #{ENV['GOOGLE_CLIENT_SECRET']}"
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           # hacky fix to OmniAuth::Strategies::OAuth2::CallbackError (csrf_detected | CSRF detected)
           # see https://github.com/omniauth/omniauth-oauth2/issues/58#issuecomment-43637421
           provider_ignores_state: Rails.env.development?
end
