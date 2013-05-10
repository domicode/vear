class SearchController < ApplicationController
  def search

    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end

    if params[:query].present?
      @posts = Post.search(params)
      render :action => 'index', :collection => @posts
    else
      redirect_to root_url
    end
  end
end
