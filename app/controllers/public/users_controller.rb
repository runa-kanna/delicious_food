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
    #特定のユーザ（@user）に関連付けられた1つの投稿全て（.foods）のデータを取得し@foodsに渡す
    @foods = @user.foods
  end

  def edit
    #URLを参考に特定のidを持ったレコードを取得する
    @user = current_user
  end

  def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    @user.update(user_params)
    #ユーザーの詳細ページへのパス
    redirect_to user_path(@user), notice: '変更しました'
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  #退会処理
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  #いいね一覧
  def favorites
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:food_id)
    @favorite_foods = Food.find(favorites)
  end
  
  #user/idの投稿履歴
  def history
    @foods = Food.where(user_id:params[:user_id]).order(created_at: :desc)
    @food = Food.find_by(user_id:params[:user_id])
    if @food == nil
      redirect_to user_path(current_user) , notice: '投稿履歴はありません'
    end
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
