Rails.application.routes.draw do
  root "tools#index"
  resources :tools
  resources :users



  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"
end
