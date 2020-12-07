Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about_us', to: 'pages#about_us', as: :about_us
  get 'blogs', to: 'pages#blogs', as: :blogs

  devise_for :users

  resources :cars do

    collection do
      get :luxury    # /cars/luxury
      get :vintage   # /cars/vintage
      get :sport     # /cars/sport
      get :off_road  # /cars/off_road
    end

    resources :rentals, only: %i[ new create show ]
      # rentals#new    <=> /cars/:car_id/rentals/new
      # rentals#create <=> /cars/:car_id/rentals
      # rentals#show   <=> /cars/:car_id/rentals/:id(.:format)

    resources :reviews, only: %i[ new create ]
      # reviews#new    <=> /cars/:car_id/reviews/new
      # reviews#create <=> /cars/:car_id/reviews

  end
    resources :rentals, only: [ :index, :destroy ]
      # rentals#index   <=> /rentals
      # rentals#destroy <=> /rentals/:id

end
