class Public::UsersController < ApplicationController
  
  #テーブル内に存在する全てのレコードのインスタンスを代入
  def index
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
    @user.update(user_params)
    #ユーザーの詳細ページへのパス
    redirect_to user_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
