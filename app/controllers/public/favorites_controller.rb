class Public::FavoritesController < ApplicationController

  def create
    food = Food.find(params[:food_id])
    favorite = current_user.favorites.new(food_id: food.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    food = Food.find(params[:food_id])
    favorite = current_user.favorites.find_by(food_id: food.id)
    favorite.destroy
    redirect_to request.referer
  end

end
