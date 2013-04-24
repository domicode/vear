class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Search

  attr_accessible :kind, :message, :created_at

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 10..140 }

  def to_indexed_json
    to_json :except => ['updated_at']
  end

  def self.search(params)
    params[:kind] = 1 if params[:kind] == 0
    params[:kind] = 0 if params[:kind] == 1

    tire.search do
      query { string params[:query].squish } if params[:query].present?
      filter :term, :kind => params[:kind] if params[:kind].present?
      sort { by :created_at, 'desc' }
    end
  end
end
