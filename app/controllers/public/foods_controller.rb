class Public::FoodsController < ApplicationController
  before_action :authenticate_user!

  #form_withに渡すための空のモデル
  def new
    @food = Food.new
  end

  #投稿データの保存
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    #保存出来たら詳細ページへ飛ぶ
    if  @food.save
        redirect_to foods_path, notice: '新しく投稿しました'
    #保存できなかったら投稿ページ
    else
        render :new, notice: '投稿に失敗しました'
    end
  end

  #テーブル内に存在する全てのレコードのインスタンスを代入
  def index
    @user = current_user
    @foods = Food.all.order(created_at: :desc)
  end

  def show
    @food = Food.find(params[:id])
    @user = User.find_by(name: 'guestuser')
    @comment = Comment.new
  end

  #編集するFoodレコードを取得
  def edit
    @food = Food.find(params[:id])
    if @food.user == current_user
      render :edit, notice: '投稿した内容を変更しました'
    else
      redirect_to foods_path, notice: '変更に失敗しました'
    end
  end

  def update
    food = Food.find(params[:id])
    if  params[:food][:image_ids]
        params[:food][:image_ids].each do |image_id|
          image = food.images.find(image_id)
          image.purge
        end
    end
    if food.update(food_params)
       redirect_to food_path(food.id), notice: '投稿した内容を変更しました'
    else
      render :edit, notice: '変更に失敗しました'
    end
  end

  def destroy
    #削除するFoodレコードを取得
    @food = Food.find(params[:id])
    #削除
    @food.destroy
    #Foodの一覧ページへのパス
    redirect_to foods_path, notice: '投稿を削除しました'
  end
  
  def map
    @food = Food.find(params[:food_id])
  end
  

  #投稿データのストロングパラメータ
  private

  def food_params
    params.require(:food).permit(:address, :latitude, :longitude, :title, :body, images: [])
  end

end
