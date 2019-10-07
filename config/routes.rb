Rails.application.routes.draw do
  root 'users#new'
  post '/', to: 'users#create'
  resources :users
end
