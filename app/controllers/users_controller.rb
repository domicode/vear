class UsersController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @user = current_user
    @post = @user.posts.build

    if params[:kind].present?
      @posts = @user.posts.where(:kind => params[:kind]).page params[:page]
    else
      @posts = @user.posts.page params[:page]
    end
    index! { root_url }
  end
end
