class PostsController < InheritedResources::Base
  before_filter :load_current_user

  def index
    @post = @user.posts.build if @user.present?
    @posts = Post.search(params)
  end

  def create
    @post = @user.posts.create(params[:post])
    create! { user_posts_path(@user) }
  end

  def destroy
    @post = @user.posts.find(params[:id])
    destroy!
  end

  def load_current_user
    @user = current_user
  end
end
