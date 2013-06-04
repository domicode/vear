class Message < ActiveRecord::Base
  attr_accessible :body, :post_id, :user_id, :created_at

  belongs_to :user
  belongs_to :post

  validates :body, :presence => true

  scope :order_asc,  :order => 'created_at ASC'
end
