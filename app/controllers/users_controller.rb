class UsersController < InheritedResources::Base
before_filter :authenticate_user!

  def index
    @user = current_user
    @post_new = @user.posts.build

    if params[:kind].present?
      @posts = @user.posts.where(:kind => params[:kind]).page params[:page]
    else
      @posts = @user.posts.page params[:page]
    end
    index! { root_url }
  end

  def posts
    @user = current_user
    @post_new = @user.posts.build

    @posts = Post.joins(:user, :messages).uniq
  end
end
