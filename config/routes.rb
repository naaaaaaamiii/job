Rails.application.routes.draw do
  # ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # ユーザー
  devise_for :users
  root to: "homes#top"

  get "search" => "searches#search" # 検索機能
  get "about"  => "homes#about"
  
  resources :posts, only: [:index, :show, :edit, :create, :update, :destroy, :new] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
      collection do
        get :confirm
      end
    end

  resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites  #いいねされた記事の一覧表示のため
        get :follows, :followers #フォローした人されてる人の一覧表示
      end
      resource :relationships, only: [:create, :destroy] # フォロー機能
  end

  resources :events do
    member do
      get :attendees#参加者一覧
      get :myevent #参加イベント一覧
    end
    resource :attendees, only: [:create, :destroy] #イベントに参加する/参加しない
  end

end

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html