Rails.application.routes.draw do
  root "tools#index"

  resources :users do
    resources :tools
  end

  resources :users do
    resources :categories
  end

  namespace :admin do
    resources :tools
  end



  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/relogin", to: "sessions#validate"
end
