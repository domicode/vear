class MessagesController < InheritedResources::Base
  before_filter :authenticate_user!, :build_new_post

  def new
    @post = Post.find(params[:post_id])
    @message = @post.messages.build
  end

  def create
    create! { messages_path }
  end

  def index
    @posts = Post.joins(:user, :messages).uniq
  end

  def build_new_post
    if current_user.present?
      @user = current_user
      @post = @user.posts.build
    end
  end
end
