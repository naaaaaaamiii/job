Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/index'
  get 'posts/edit'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: "homes#top"
end
