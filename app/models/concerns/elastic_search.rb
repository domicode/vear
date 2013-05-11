module Concerns::ElasticSearch
  extend ActiveSupport::Concern

  included do
    include Tire::Model::Search
    include Tire::Model::Callbacks

    settings :analysis => {
      :filter => {
        :word_delimiter  => {
          "preserve_original" => true,
          "type" => "word_delimiter"
        }
      },
      :analyzer => {
        :str_analyzer => {
          "tokenizer"    => "letter",
          "filter"       => ["lowercase", "asciifolding", "trim", "word_delimiter"]
        }
      }
    } do
      mapping do
        indexes :kind, :type => 'string', :analyzer => 'keyword'
        indexes :body, :type => 'string', :analyzer => 'str_analyzer'
        indexes :user_id, :type => 'integer'
      end
    end
  end

  module ClassMethods
    def search(params)
      tire.search do
        filter :term, :kind => params[:kind] if params[:kind].present?
        query { string params[:query].squish } if params[:query].present?
        sort { by :_score, :desc }
        highlight :body
        page = (params[:page] || 1).to_i
        search_size = 24
        from (page -1) * search_size
        size search_size
      end
    end
  end
end
