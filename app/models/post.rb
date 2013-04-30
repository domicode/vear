class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :kind, :message, :created_at, :id, :user_id

  belongs_to :user, :dependent => :destroy

  validates :kind, :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => 1 }
  validates :message, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'

  paginates_per 24
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
      query { string params[:query].squish } if params[:query].present?
      filter :term, :kind => params[:kind] if params[:kind].present?
      sort { by :_score, :desc }
      page = (params[:page] || 1).to_i
      search_size = 24
      from (page -1) * search_size
      size search_size
    end
  end
end
