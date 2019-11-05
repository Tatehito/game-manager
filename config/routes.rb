Rails.application.routes.draw do
  root 'users#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get 'amazon/search'
  resources :users
  resources :games
end
