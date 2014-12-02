# coding: utf-8

module Preflight
  module Rules

    # Função baseada na própria pageBoxSize do Preflight, porém conta com a possibilidade de comparar o tamanho do arquivo X item 
    # além de gerar issues diferentes para cada situação.

    class FileSize
      include Preflight::Measurements

      attr_reader :issues

      def initialize(largura, altura, sizeMm)
        @largura = largura.to_f
        @altura = altura.to_f
        @sizeMm = sizeMm
      end

      def page=(page)
        @issues = []

        if (@sizeMm[0] > @largura || @sizeMm[1] > @altura)
            @issues << Issue.new(0, "sizeview", "Tamanho esperado: #{@largura}x#{@altura}<br/>Tamanho Encontrado: #{@sizeMm[0]}x#{@sizeMm[1]}",
              self,
              :page => 1,
              :box => 'MediaBox',
              :box_width => @sizeMm[0],
              :box_height => @sizeMm[1])

        elsif (@sizeMm[0] < @largura || @sizeMm[1] < @altura)
            @issues << Issue.new(2, "sizeview", "Arquivo menor que o tamanho esperado",
              self,
              :page => 1,
              :box => 'MediaBox',
              :box_width => @sizeMm[0],
              :box_height => @sizeMm[1])
          
        end

      end

    end
  end
end