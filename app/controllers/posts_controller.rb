class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @user_posts = @user.posts
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
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
          render :new, locals: { post: }
        end
      end
    end
  end

  def show
    @user_post = Post.includes(:comments).find(params[:id])
    @user_id = current_user.id
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
