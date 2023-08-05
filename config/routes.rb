Rails.application.routes.draw do
  
  devise_for :users
  root to: "homes#top"

  resources :posts, only: [:index, :show, :edit, :create, :update, :destroy, :new]
  resources :users, only: [:index, :show, :edit, :update, :new]

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
