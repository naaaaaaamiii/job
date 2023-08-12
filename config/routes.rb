Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  get "search" => "searches#search" # 検索機能

  resources :posts, only: [:index, :show, :edit, :create, :update, :destroy, :new] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    end

  resources :users, only: [:index, :show, :edit, :update, :new] do
      member do
        get :favorites  #いいねされた記事の一覧表示のため
      end
  end
end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html