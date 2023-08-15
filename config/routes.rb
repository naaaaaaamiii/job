Rails.application.routes.draw do
  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # ユーザー
  devise_for :users
  root to: "homes#top"

  get "search" => "searches#search" # 検索機能

  resources :posts, only: [:index, :show, :edit, :create, :update, :destroy, :new] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
      collection do
        get :confirm
      end
    end

  resources :users, only: [:index, :show, :edit, :update, :new] do
      member do
        get :favorites  #いいねされた記事の一覧表示のため
        get :follows, :followers #フォローした人されてる人の一覧表示
      end
      resource :relationships, only: [:create, :destroy] # フォロー機能
  end
  
  resources :event
  
end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html