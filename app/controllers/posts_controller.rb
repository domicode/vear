class PostsController < InheritedResources::Base
  def index
    @post = Post.new
    @posts = Post.page params[:page]
  end
end
