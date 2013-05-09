class PostsController < InheritedResources::Base
  def index
    @post = Post.new
    if params[:type].present?
      @posts = Post.where(:type => params[:type]).page params[:page]
    else
      @posts = Post.page params[:page]
    end
  end
end
