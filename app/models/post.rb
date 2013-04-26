class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Search

  attr_accessible :kind, :message, :created_at

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 10..140 }

  settings :analysis => {
    :filter => {
      :substring  => {
        "type"     => "nGram",
        "min_gram" => 1,
        "max_gram" => 20
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
    mapping { indexes :message, :type => 'string', :index_analyzer => 'str_index_analyzer', :search_analyzer => 'str_search_analyzer' }
  end

  def self.search(params)
    params[:kind] = 1 if params[:kind] == 0
    params[:kind] = 0 if params[:kind] == 1

    tire.search(:load => true) do
      query { text(:message, params[:query].squish) } if params[:query].present?
      highlight :message
      sort { by :_score, :desc }
      filter :term, :kind => params[:kind] if params[:kind].present?
      size 100
    end
  end
end
