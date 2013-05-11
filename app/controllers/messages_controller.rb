class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!, :build_new_post

  def new
    @post = Post.find(params[:post_id])
    @message = @post.messages.build(:user_id => current_user.id)
  end

  def create
    @message = @post.messages.build(:user_id => current_user.id)
    create! { messages_path }
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
