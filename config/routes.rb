Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :genres, only: [:index]
      resources :tracks, only: [:index]
      resources :artists, only: [:index]
      resources :recommendations, only: [:index]
      get '/login', to: "auth#create"
      get '/callback', to: "users#create"
      get '/logged_in', to: "users#logged_in"
      get '/track_recs', to: "recommendations#tracks"
      get '/artist_recs', to: "recommendations#artists"
      get '/genre_recs', to: "recommendations#genres"
      get '/current_user', to: "application#curr_user"
      delete '/delete_user', to: "users#destroy"
    end
  end
end
