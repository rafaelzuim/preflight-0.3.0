# coding: utf-8

module Preflight
  module Rules
    # check the file has a document ID
    #
    # Arguments: none
    #
    # Usage:
    #
    #   class MyPreflight
    #     include Preflight::Profile
    #
    #     rule Preflight::Rules::DocumentId
    #   end
    #
    class DocumentId

      def check_hash(ohash)
        if ohash.trailer[:ID].nil?
          [Issue.new(1, "pdfview", "ID do arquivo inexistente", self)]
        else
          []
        end
      end
    end
  end
end
