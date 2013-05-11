class PostsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => :index

  def index
    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end

    if params[:kind].present?
      @posts = Post.where(:kind => params[:kind]).page params[:page]
    else
      @posts = Post.page params[:page]
    end
  end

  def create
    create! { root_url }
  end
end
