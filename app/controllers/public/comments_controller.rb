class Public::CommentsController < ApplicationController
  
  # def new
  #   #どの投稿に対してコメントするのかをfood_idを使って探す
  #   @food = Food.find(params[:food_id])
  #   #コメントを投稿するためのインスタンス変数
  #   @comment = Comment.new
  #   #ゲストユーザーの場合はコメントできない
  #   if current_user.name == "guestuser"
  #     redirect_to food_path(@food), notice: "ゲストユーザーはコメントすることができません"
  #   end
  # end
  
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
