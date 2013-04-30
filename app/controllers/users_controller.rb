class UsersController < InheritedResources::Base
  respond_to :js

  before_filter :authenticate_user!

  def index
    @post = Post.new
    @user = current_user
  end
end
