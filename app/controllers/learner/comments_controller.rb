class Learner::CommentsController < ApplicationController

  def create
    comment = current_learner_user.comments.new(comment_params) 
    @article = Article.find(params[:article_id])
    comment.article_id = @article.id
    if comment.save
      flash[:success] = "Object successfully created"
      @new_comment = Comment.new
      @comments = @article.comments.order(created_at: "desc")
    else
      flash[:error] = "Something went wrong"
      redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @comment_id = @comment.reply_to
      @reply_count = Comment.where(reply_to: @comment_id).count
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
      redirect_to request.referer
    end
  end
  
private

  def comment_params
    params.require(:comment).permit(:content, :reply_to)
  end

end
