class Post < ActiveRecord::Base
  include Concerns::ElasticSearch

  attr_accessible :type, :body, :created_at, :id, :user_id

  belongs_to :user
  has_many :messages

  validates :type, :presence => true
  validates :body, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'
end

class Offer < Post; end
class Demand < Post; end
