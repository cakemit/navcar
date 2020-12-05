Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about_us', to: 'pages#about_us', as: :about_us
  get 'blogs', to: 'pages#blogs', as: :blogs

  devise_for :users

  resources :cars do
    resources :rentals, only: %i[ new create show ]
    resources :reviews, only: %i[ new create ]
  end
    resources :rentals, only: [ :index, :destroy ]
end
