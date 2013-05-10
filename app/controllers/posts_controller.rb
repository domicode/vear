class PostsController < InheritedResources::Base
  def index
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
