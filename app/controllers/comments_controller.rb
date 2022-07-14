class CommentsController < ApplicationController
  def new
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params.merge(user: current_user))
    respond_to do |format|
      format.html do
        if comment.save
          comment.counter_updater
          flash[:success] = 'New comment added'
          redirect_to "/users/#{params[:user_id]}/posts/#{post.id}"
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: }
        end
      end
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
