class LikesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    like = Like.new(user:, post:)
    respond_to do |format|
      format.html do
        if like.save
          like.counter_updater
          flash[:success] = 'Liked'
        else
          flash.now[:error] = 'Error: Like could not be saved'
        end
        redirect_to user_post_likes_path
      end
    end
  end
end
