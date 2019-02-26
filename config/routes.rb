Rails.application.routes.draw do
  resources :genres
  resources :tracks
  resources :artists
  get '/current_user', to: "application#curr_user"
  namespace :api do
    namespace :v1 do
      resources :users
        get '/login', to: "auth#create"
        get '/callback', to: "users#create"
    end
  end
end
