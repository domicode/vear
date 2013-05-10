class PostsController < InheritedResources::Base
  def index
    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end

    if params[:type].present?
      @posts = Post.where(:type => params[:type]).page params[:page]
    else
      @posts = Post.page params[:page]
    end
  end

  def create
    create! { root_url }
  end
end
