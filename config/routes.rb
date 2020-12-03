Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :cars do
    resources :rentals
    resources :reviews, only: [:new, :create, :index]
  end
end
