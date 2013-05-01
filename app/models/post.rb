class Post < ActiveRecord::Base
  include Concerns::ElasticSearch
  attr_accessible :kind, :message, :created_at, :id, :user_id

  belongs_to :user, :dependent => :destroy

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'
end
