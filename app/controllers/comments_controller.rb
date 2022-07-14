class CommentsController < ApplicationController
  def new
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(text: params[:text], user: current_user, post:)
    respond_to do |format|
      format.html do
        if comment.save
          comment.counter_updater
          flash[:success] = 'New comment added'
          redirect_to user_post_comments_path
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: }
        end
      end
    end
  end
end
