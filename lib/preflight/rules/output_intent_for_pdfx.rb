# coding: utf-8

module Preflight
  module Rules

    # Check the target PDF contains an output intent suitable for PDFX
    #
    # Arguments: none
    #
    # Usage:
    #
    #   class MyPreflight
    #     include Preflight::Profile
    #
    #     rule Preflight::Rules::OutputIntentForPdfx
    #   end
    #
    class OutputIntentForPdfx

      def check_hash(ohash)
        intents = output_intents(ohash).select { |dict|
          ohash.object(dict)[:S] == :GTS_PDFX
        }

        if intents.size != 1
          [Issue.new(1, "pdfview", "Erro output GTS_PDFX", self)]
        else
          []
        end
      end

      private

      def output_intents(ohash)
        root    = ohash.object(ohash.trailer[:Root])
        intents = ohash.object(root[:OutputIntents])
        intents || []
      end

    end
  end
end
