class Post < ActiveRecord::Base
  attr_accessible :kind, :message

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 10..140 }
end
