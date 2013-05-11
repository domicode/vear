class Message < ActiveRecord::Base
  attr_accessible :body, :post_id, :user_id

  belongs_to :user
  belongs_to :post

  default_scope :order => 'created_at ASC'
end
