Rails.application.routes.draw do
  # Route for fetching followers and following of a user
  get "users/:id/followers", to: "users#followers"
  get "users/:id/following", to: "users#following"

  resources :users do
    resources :stories
    get "reels", to: "posts#reel"
    get "get_comments", to: "posts#get_comments"
    get "individual_post", to: "posts#individual_post"
    resources :posts do
      resources :comments
      
    end
  end

  # Separate follows routes (create and destroy follow relationships)
  resources :follows, only: [:create, :destroy]
  get 'sent_messages', to: 'messages#sent_messages'
  get 'received_messages', to: 'messages#received_messages'
  resources :messages

  # Session routes for login/logout
  resources :sessions, only: [:create, :destroy]

  # Route to check app health
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root "posts#index"
end
