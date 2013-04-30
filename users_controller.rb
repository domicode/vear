class UsersController < InheritedResources::Base
  respond_to :js
  def index
    @user = User.new
  end

  def create
    create!
  end
end
