class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @user_posts = @user.posts.includes(comments: [:user])
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.new(post_params.merge(comments_counter: 0, likes_counter: 0))
    respond_to do |format|
      format.html do
        if post.save
          post.counter_updater
          flash[:success] = 'Post saved successfully'
          redirect_to user_posts_path
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new
        end
      end
    end
  end

  def show
    @user_post = Post.includes(comments: [:user]).find(params[:id])
    @user_id = params[:user_id]
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'Post successfully deleted'
    redirect_to "/users/#{params[:user_id]}/posts"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
