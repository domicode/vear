class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!, :build_new_post

  has_scope :order_asc

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
    create! { post_messages_path(post) }
  end

  def index
    @post = Post.find(params[:post_id])
    @message = @post.messages.build(:post_id => @post.id,
                                   :user_id => current_user.id)
    @messages = @post.messages
  end

  def build_new_post
    if current_user.present?
      @user = current_user
      @post_new = @user.posts.build
    end
  end
end
