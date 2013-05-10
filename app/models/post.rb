class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :type, :body, :created_at, :id, :user_id

  belongs_to :user

  validates :type, :presence => true
  validates :body, :presence => true, :length => { :in => 5..140 }

  default_scope :order => 'created_at DESC'

  settings :analysis => {
    :filter => {
      :nGram  => {
        "min_gram" => 1,
        "max_gram" => 15,
        "type" => "nGram"
      },
      :word_delimiter  => {
        "preserve_original" => true,
        "type" => "word_delimiter"
      }
    },
    :analyzer => {
      :str_analyzer => {
        "tokenizer"    => "letter",
        "filter"       => ["lowercase", "asciifolding", "trim", "word_delimiter", "nGram"]
      }
    }
  } do
    mapping do
      indexes :post_type, :type => 'string', :analyzer => 'keyword', :as => 'type'
      indexes :body, :type => 'string', :analyzer => 'str_analyzer'
      indexes :user_id, :type => 'integer'
    end
  end

  def self.search(params)
    Post.tire.search do
      filter :term, :post_type => params[:type] if params[:type].present?
      query { string params[:query].squish } if params[:query].present?
      sort { by :_score, :desc }
      page = (params[:page] || 1).to_i
      search_size = 24
      from (page -1) * search_size
      size search_size
    end
  end
end

class Offer < Post; end
class Demand < Post; end
