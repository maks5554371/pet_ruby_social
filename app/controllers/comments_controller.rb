# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "Комментарий добавлен" }
      end
    else
      redirect_to @post, alert: "Ошибка при добавлении комментария"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: "Комментарий удалён" }
      end
    else
      redirect_to @post, alert: "Вы можете удалять только свои комментарии"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
