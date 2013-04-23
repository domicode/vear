class PostsController < InheritedResources::Base
  def index
    @post = Post.new

    index! { root_url }
  end

  def create
    create! do |success, failure|
      success.html { redirect_to root_url}
      failure.html { render action: 'index' }
    end
  end
end
