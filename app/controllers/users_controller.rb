class UsersController < InheritedResources::Base
  respond_to :js

  before_filter :authenticate_user!

  def index
    @user = current_user
    @post = @user.posts.build

    params[:user_id] = current_user.id
    @posts = @user.posts.search(params)
  end
end
