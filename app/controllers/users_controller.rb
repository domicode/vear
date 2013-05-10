class UsersController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @user = current_user
    @post = @user.posts.build

    if params[:type].present?
      @posts = @user.posts.where(:type => params[:type]).page params[:page]
    else
      @posts = @user.posts.page params[:page]
    end
    index! { root_url }
  end
end
