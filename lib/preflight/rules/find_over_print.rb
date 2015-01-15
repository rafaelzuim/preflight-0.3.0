# coding: utf-8

module Preflight
  module Rules

    # Função baseada na própria pageBoxSize do Preflight, porém conta com a possibilidade de comparar o tamanho do arquivo X item 
    # além de gerar issues diferentes para cada situação.

    class FindOverPrint

      def check_hash(ohash)

        begin

            if ohash.trailer[:OPM] == 1
              [Issue.new(1, "colorview", "Cor sobreposta encontrada", self, :hash => ohash)]

            elsif ohash.trailer[:OPM].nil?
              [Issue.new(1, "colorview", "Não achou overprint", self, :hash => ohash)]
            end

        rescue
          [Issue.new(1, "colorview", "CAGOU", self, :hash => ohash)]
        end

      end

    end
  end
end