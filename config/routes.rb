# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations}
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "users#index"
  devise_scope :user do
    authenticated :user do
      root to: 'users#index'
    end
    unauthenticated :user do
      root to: 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create, :new]
    end
  end

  # API Routes
  get '/api/users/:user_id/posts', to: 'api_endpoints#user_posts', as: 'api_user_posts'
  get '/api/users/:user_id/posts/:post_id/comments', to: 'api_endpoints#user_post_comments', as: 'api_posts_comments'
  post '/api/users/:user_id/posts/:post_id/comments', to: 'api_endpoints#new_comment', as: 'new_post_comment'
end
