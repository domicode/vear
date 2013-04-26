class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :kind, :message, :created_at

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 10..140 }

  default_scope :order => 'created_at DESC'

  settings :analysis => {
    :filter => {
      :substring  => {
        "type"     => "nGram",
        "min_gram" => 1,
        "max_gram" => 140
      }
    },
    :analyzer => {
      :str_search_analyzer => {
        "tokenizer"    => "keyword",
        "filter"       => "lowercase"
      },
      :str_index_analyzer => {
        "tokenizer"    => "keyword",
        "filter"       => ["lowercase", "substring"]
      }
    }
  } do
    mapping do
      indexes :kind
      indexes :message, :type => 'string', :index_analyzer => 'str_index_analyzer', :search_analyzer => 'str_search_analyzer'
    end
  end

  def self.search(params)
    params[:kind] = 1 if params[:kind] == 0
    params[:kind] = 0 if params[:kind] == 1

    tire.search(:load => true) do
      query { match(:message, params[:query].squish) } if params[:query].present?
      filter :term, :kind => params[:kind] if params[:kind].present?
      sort { by :_score, :desc }
      highlight :message
      size 100
    end
  end
end
