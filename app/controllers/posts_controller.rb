class PostsController < InheritedResources::Base
  respond_to :js

  def index
    @post = Post.new

    @posts = Post.search(params)

  end

  def create
    create! do |success, failure|
      success.html { redirect_to root_url}
      failure.html { render action: 'index' }
    end
  end
end
