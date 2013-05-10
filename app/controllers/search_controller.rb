class SearchController < ApplicationController
  def search

    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end

    @posts = Post.search(params)

    render :action => 'index', :collection => @posts
  end
end
