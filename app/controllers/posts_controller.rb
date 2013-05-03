class PostsController < InheritedResources::Base
  def index
    @post = Post.new
    @posts = Post.search(params)
  end
end
