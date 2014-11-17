# coding: utf-8

module Preflight
  module Rules
    # ensure the PDF version of the file under review is not more recent
    # than desired
    #
    # Arguments: the maximum version
    #
    # Usage:
    #
    #   class MyPreflight
    #     include Preflight::Profile
    #
    #     rule Preflight::Rules::MaxVersion, 1.4
    #   end
    #
    class MaxVersion

      def initialize(max_version)
        @max_version = max_version.to_f
      end

      def check_hash(ohash)
        if ohash.pdf_version > @max_version
          [Issue.new(1, "pdfview", "A versão do PDF deve ser #{@max_version} ou inferior", self, :max_version     => @max_version,
                                                                             :current_version => ohash.pdf_version)]
        else
          []
        end
      end
    end
  end
end
