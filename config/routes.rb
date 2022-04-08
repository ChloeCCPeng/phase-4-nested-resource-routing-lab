Rails.application.routes.draw do
  
  resources :users, only: [:show, :create] do
    resources :items, only: [:show, :index, :create]
  end
  resources :items, only: [:index, :crete, :show]
end