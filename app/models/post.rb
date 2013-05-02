class ValidateKind < ActiveModel::Validator
  def validate(record)
    unless record.kind == 'offer' || record.kind == 'demand'
      record.errors[:kind] << 'Kind needs to be offer or post'
    end
  end
end

class Post < ActiveRecord::Base
  include Concerns::ElasticSearch
  include ActiveModel::Validations

  attr_accessible :kind, :message, :created_at, :id, :user_id

  belongs_to :user, :dependent => :destroy

  validates :kind, :presence => true
  validates_with ValidateKind
  validates :message, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'
end
