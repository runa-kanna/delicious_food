class Admin::UsersController < ApplicationController
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

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_active)
  end

end
