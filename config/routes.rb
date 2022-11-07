Rails.application.routes.draw do

  #admin側
  namespace :admin do
    #投稿
    resources :foods, only: [:index, :show, :destroy] do
      #コメント
      resources :comments, only: [:destroy]
    end
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'homes/top'
  end


  #ユーザー側
  scope module: :public do
    #投稿
    resources :foods do
      #いいね
      resource :favorites, only: [:create, :destroy]
      #コメント
      resources :comments, only: [:create, :destroy]
    end
    #user
    resources :users,only:[:index, :show, :edit, :update] do
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    # 退会機能
    get 'users/:id/unsubscribe' => 'users#unsubscribe',as: 'unsubscribe_user'
    patch 'users/:id/withdraw' => 'users#withdraw',as: 'withdraw_user'

    #top.about
    root :to =>"homes#top"
    get '/about'=>'homes#about',as: 'about'

  end


  #管理者
  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update]

    resources :foods, only:[:index, :show, :destroy]

    get '/' =>'homes#top'
  end


  # ユーザー用
  # URL /users/sign_in ...
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  #ゲストユーザー用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
