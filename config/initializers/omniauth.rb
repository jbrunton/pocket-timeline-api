Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           # hacky fix to OmniAuth::Strategies::OAuth2::CallbackError (csrf_detected | CSRF detected)
           # see https://github.com/omniauth/omniauth-oauth2/issues/58#issuecomment-43637421
           provider_ignores_state: Rails.env.development?,
           # otherwise vulnerable to session overflow and redirection attacks
           # see https://github.com/omniauth/omniauth/issues/910
           origin_param: false
end
