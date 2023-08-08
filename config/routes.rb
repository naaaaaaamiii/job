Rails.application.routes.draw do
  
  devise_for :users
  root to: "homes#top"
  
  # タグの検索で使用する
  get "search_tag" => "posts#search_tag"

  resources :posts, only: [:index, :show, :edit, :create, :update, :destroy, :new] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update, :new]

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
