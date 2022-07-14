class LikesController < ApplicationController
  def new
    like = Like.new
    respond_to do |format|
      format.html { render :new, locals: { like: } }
    end
  end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    like = Like.new(user:, post:)
    respond_to do |format|
      format.html do
        if like.save
          like.counter_updater
          flash[:success] = 'Liked'
          redirect_to "/users/#{user.id}/posts/#{post.id}"
        else
          flash.now[:error] = 'Error: Like could not be saved'
          render :new, locals: { like: }
        end
      end
    end
  end
end
