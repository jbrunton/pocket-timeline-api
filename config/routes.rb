Rails.application.routes.draw do
  post 'rating/score'
  get 'rating/ratings'

  get 'timelines', to: 'timeline#index'
  get 'timelines/:id', to: 'timeline#show'

  get 'home/index'
  get 'home/google'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  get '/auth/:provider/callback', :to => 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  post '/auth/google_oauth2/signin', :to => 'sessions#signin'

  get '/auth/signout', :to => 'sessions#destroy'

  get '/user/profile'
end
