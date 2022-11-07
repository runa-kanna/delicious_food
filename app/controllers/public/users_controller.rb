class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

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

  def unsubscribe
    @user = User.find(params[:id])
  end

  #退会処理
  def withdraw
    @user = current_customer
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_active,)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
