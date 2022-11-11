Rails.application.routes.draw do

  # ユーザー用ログイン・新規登録
  # URL /users/sign_in ...
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
    #ゲストユーザー用ログイン
  devise_scope :user do
    get 'users_guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # 管理者用ログイン
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  
  #管理者側
  namespace :admin do
    #top
    get '/' =>'homes#top'
    #user
    resources :users, only:[:index, :show, :edit, :update]
    #投稿
    resources :foods, only: [:index, :show, :destroy] do
      #コメント
      resources :comments, only: [:destroy]
    end
    #search
    get "search" => "searches#search"
  end


  #ユーザー側
  scope module: :public do
    #投稿
    resources :foods do
      #いいね
      resource :favorites, only: [:index, :create, :destroy]
      #コメント
      resources :comments, only: [:create, :destroy]
    end
    #user
    resources :users,only:[:index, :show, :edit, :update] do
      #user/idのいままでの投稿一覧
      get 'history' => 'users#history', as: 'history'
      #いいね一覧
      get 'favorites' => 'users#favorites', as: 'favorites'
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    # 退会機能
    get 'users/:id/unsubscribe' => 'users#unsubscribe',as: 'unsubscribe_user'
    patch 'users/:id/withdraw' => 'users#withdraw',as: 'withdraw_user'

    #top.about.searth
    root :to =>"homes#top"
    get '/about'=>'homes#about',as: 'about'
    get "search" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
