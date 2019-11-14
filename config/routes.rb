Rails.application.routes.draw do
  root 'pages#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get '/search', to: 'amazon#search'
  resources :games
end
