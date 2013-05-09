class UsersController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @user = current_user
    @post = @user.posts.build

    @posts = @user.posts.page params[:page]
  end
end
