class UsersController < InheritedResources::Base
  respond_to :js

  before_filter :authenticate_user!

  def index
    @user = current_user

    @post = @user.posts.build

    @offers = @user.posts.where("kind = ?", 1)
    @demands = @user.posts.where("kind = ?", 0)
  end
end
