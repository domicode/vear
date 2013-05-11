class Post < ActiveRecord::Base
  include Concerns::ElasticSearch

  attr_accessible :kind, :body, :created_at, :id, :user_id

  belongs_to :user
  has_many :messages

  validates :kind, :presence => true
  validates :body, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'
end
