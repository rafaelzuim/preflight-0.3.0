# coding: utf-8

module Preflight
  module Rules

    # For PDFX/1a, every page must have MediaBox, plus either ArtBox or
    # TrimBox
    #
    # Arguments: none
    #
    # Usage:
    #
    #   class MyPreflight
    #     include Preflight::Profile
    #
    #     rule Preflight::Rules::PrintBoxes
    #   end
    #
    class PrintBoxes

      attr_reader :issues

      def page=(page)
        dict = page.attributes

        if dict[:MediaBox].nil?
          @issues = [Issue.new(1, "pdfview", "Todo arquivo PDF deve ter um MediaBox", self, :page => page.number)]
        elsif dict[:ArtBox].nil? && dict[:TrimBox].nil?
          @issues = [Issue.new(1, "pdfview", "Todo arquivo PDF deve ter um ArtBox ou um TrimBox", self, :page => page.number)]
        elsif dict[:ArtBox] && dict[:TrimBox]
          @issues = [Issue.new(1, "pdfview", "Arquivo não pode ter ArtBox e TrimBox na mesma página", self, :page => page.number)]
        else
          @issues = []
        end
      end
    end
  end
end
