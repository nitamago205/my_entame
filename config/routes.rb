Rails.application.routes.draw do

  devise_scope :user do
    post 'users/sign_up' => 'public/registrations#create'
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }



  namespace :admin do
      resources :genres, only: [:index, :create, :edit, :update, :destroy]
      resources :users, only: [:index, :show, :edit, :update, :destroy]
      resources :posts, only: [:index, :show, :edit, :update, :destroy] do
        resources :my_selects, only: [:edit, :update, :destroy]
        resources :post_comments, only: [:destroy]
      end
  end

  scope module: "public" do
      root to: "homes#top"
      get "/users/:id/confirm" => "users#confirm", as: "confirm" #退会確認画面の表示
      patch "/users/:id/out" => "users#out", as: "out" #退会フラグを切り替える
      get "/genre/:id" => "genres#show"
      resources :users, only: [:index, :show, :edit, :update] do
        resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
      resources :posts do
        resources :post_comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
        resources :my_selects, only: [:new, :create, :edit, :update, :destroy]
      end
      resources :notifications, only: [:index, :destroy]
  end

end
