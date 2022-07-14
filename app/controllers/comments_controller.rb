class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(text: params[:text], user: current_user, post:)
    respond_to do |format|
      format.html do
        if comment.save
          comment.counter_updater
          flash[:success] = 'New comment added'
        else
          flash.now[:error] = 'Error: Comment could not be saved'
        end
        redirect_to "/users/#{params[:user_id]}/posts/#{params[:post_id]}"
      end
    end
  end
end
