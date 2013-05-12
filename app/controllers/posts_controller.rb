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
    create! do |success, failure|
      success.html { redirect_to root_url}
      failure.html { redirect_to root_url }
    end
  end
end
