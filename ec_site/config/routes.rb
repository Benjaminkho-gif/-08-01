Rails.application.routes.draw do
  # Devise routes for Admins
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  # Devise routes for Users
  devise_for :users

  # User sign_out route fix
  devise_scope :user do
    # Set the root for users to login page
    root "users/sessions#new"
  end

  # Custom routes for other resources
  resources :tags, only: [:index, :new, :create, :destroy]
  resources :books
  resources :mypages, only: [:show]
  resources :products, only: [:index, :show]
  resources :carts, only: [:show, :destroy]
  resources :line_items, only: [:create]

  # Orders
  resources :orders, only: [:new, :create] do
    collection do
      get :confirm  
    end
    member do
      get :complete
    end
  end

  # Search functionality
  get '/search', to: 'searchs#search'

  # If you want to use sign_out link for users in views (correct method handling):
  # Example:
  # <%= link_to 'Sign Out', destroy_user_session_path, method: :delete %>
end
