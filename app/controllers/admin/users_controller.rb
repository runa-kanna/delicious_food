class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    #usersテーブルに保存されている全てのデータを取得して@usersに格納
    @users = User.all
  end

  def show
    #URLに記載されたIDを参考に、必要なUserモデルを取得
    @user = User.find(params[:id])
    #特定のユーザ（@user）に関連付けられた投稿全て（.foods）を取得し@foodsに渡す
    @foods = @user.foods
  end

  def edit
    #URLを参考に特定のidを持ったレコードを取得する
    @user = User.find(params[:id])
  end

  def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    if @user.update(user_params)
    #アドミンのユーザーの詳細ページへのパス
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  #user/idの投稿履歴
  def history
    @user = User.find_by(params[:user_id])
    @foods = Food.where(user_id:params[:user_id]).order(created_at: :desc)
  end
    

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_active)
  end

end
