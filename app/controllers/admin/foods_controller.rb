class Admin::FoodsController < ApplicationController
  def index
    @foods = Food.all.order(created_at: :desc)
  end

  def show
    @food = Food.find(params[:id])
  end

  def destroy
    #削除するFoodレコードを取得
    @food = Food.find(params[:id])
    #削除
    @food.destroy
    #Foodの一覧ページへのパス
    redirect_to admin_foods_path
  end

end
