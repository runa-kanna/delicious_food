class Public::FoodsController < ApplicationController

  #form_withに渡すための空のモデル
  def new
    @food = Food.new
  end

  #投稿データの保存
  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    #保存出来たら一覧ページへ飛ぶ
    if  @food.save
        redirect_to foods_path
    #保存できなかったら投稿ページ
    else
        render :new
    end
  end

  #テーブル内に存在する全てのレコードのインスタンスを代入
  def index
    @foods = Food.all.order(created_at: :desc)
  end

  def show
    @food = Food.find(params[:id])
  end

  #編集するFoodレコードを取得
  def edit
    @food = Food.find(params[:id])
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
       redirect_to food_path(food.id)
    else
      render :edit
    end
  end

  def destroy
    #削除するFoodレコードを取得
    @food = Food.find(params[:id])
    #削除
    @food.destroy
    #Foodの一覧ページへのパス
    redirect_to foods_path
  end




  #投稿データのストロングパラメータ
  private

  def food_params
    params.require(:food).permit(:title, :body, images: [])
  end

end
