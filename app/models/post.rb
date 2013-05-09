class ValidateKind < ActiveModel::Validator
  def validate(record)
    unless record.kind == 'offer' || record.kind == 'demand'
      record.errors[:kind] << 'Kind needs to be offer or post'
    end
  end
end

class Post < ActiveRecord::Base

  attr_accessible :kind, :body, :created_at, :id, :user_id

  belongs_to :user

  validates :kind, :presence => true
  validates_with ValidateKind
  validates :body, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'
end
