Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
   resources :genres, only: [:index, :create, :edit, :update, :destroy]
   resources :users, only: [:index, :show, :edit, :update, :destroy]
   resources :posts, only: [:index, :show, :edit, :update, :destroy] do
    resources :my_selects, only: [:show, :edit, :update, :destroy]
   end
  end




end
