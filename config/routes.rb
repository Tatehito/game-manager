Rails.application.routes.draw do
  root 'pages#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/signout', to: 'sessions#destroy'
  get '/pre_search', to: 'pages#search'
  get '/search', to: 'search#index'
  resources :games
end
