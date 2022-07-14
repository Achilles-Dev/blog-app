class LikesController < ApplicationController
  def create
    @id = current_user.id
    post = Post.find(params[:post_id])
    like = Likes.new(user: current_user, post:)
    respond_to do |format|
      format.html do
        if like.save
          like.counter_updater
          flash[:success] = 'Liked'
        else
          flash.now[:error] = 'Error: Like could not be saved'
        end
        redirect_to "/users/#{@id}/posts/#{params[:post_id]}"
      end
    end
  end
end
