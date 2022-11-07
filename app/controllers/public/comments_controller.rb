class Public::CommentsController < ApplicationController
  
  def create
    food = Food.find(params[:food_id])
    comment = current_user.comments.new(comment_params)
    comment.food_id = food.id
    comment.save
    redirect_to food_path(food)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to food_path(params[:food_id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
