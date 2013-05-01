class UsersController < InheritedResources::Base
  respond_to :js

  before_filter :authenticate_user!

  def index
    @user = current_user
    @post = @user.posts.build

    params[:user_id] = @user.id
    @posts = Post.search(params)
  end
end
