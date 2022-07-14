class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = @user.posts
  end

  def new
    @id = current_user.id
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    @id = current_user.id
    post = Post.new(title: params[:title], text: params[:text], user: current_user, comments_counter: 0,
                    likes_counter: 0)
    respond_to do |format|
      format.html do
        if post.save
          post.counter_updater
          flash[:success] = 'Post saved successfully'
          redirect_to [post.user, post] # "/users/#{@id}/posts"
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, locals: { post: }
        end
      end
    end
  end

  def show
    @user_post = Post.find_by(user_id: params[:user_id], id: params[:id])
    @id = current_user.id
  end
end
