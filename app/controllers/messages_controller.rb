class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!, :build_new_post

  def new
    post = Post.find(params[:post_id])
    @message = post.messages.build(:post_id => post.id,
                                   :user_id => current_user.id)
  end

  def create
    post = Post.find(params[:post_id])
    @message = post.messages.build(:post_id => post.id,
                                   :user_id => current_user.id,
                                   :body => params[:message][:body])
    create! { ([@message.post, @message]) }
  end

  def index
    @posts = Post.joins(:messages).uniq
  end

  def build_new_post
    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end
  end
end
