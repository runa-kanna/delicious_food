Rails.application.routes.draw do

  namespace :admin do
    get 'foods/index'
    get 'foods/show'
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
    resources :foods

    resources :users,only:[:index, :show, :edit, :update]
    get 'users/unsubscribe',as: 'unsubscribe'
    patch 'users/withdraw',as: 'withdraw'

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
  # URL /customers/sign_in ...
  devise_for :user, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
