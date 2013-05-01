module Concerns::ElasticSearch
  extend ActiveSupport::Concern

  included do
    include Tire::Model::Search
    include Tire::Model::Callbacks

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
        indexes :kind, :type => 'integer'
        indexes :message, :type => 'string', :analyzer => 'str_analyzer'
        indexes :user_id, :type => 'integer'
      end
    end
  end

  module ClassMethods
    def search(params)
      params[:kind] = 1 if params[:kind] == 0
      params[:kind] = 0 if params[:kind] == 1

      tire.search(:load => true) do
        query { string params[:query].squish } if params[:query].present?
        filter :term, :kind => params[:kind] if params[:kind].present?
        filter :term, :user_id => params[:user_id] if params[:user_id].present?
        sort { by :_score, :desc }
        page = (params[:page] || 1).to_i
        search_size = 24
        from (page -1) * search_size
        size search_size
      end
    end
  end
end
