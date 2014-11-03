# coding: utf-8

require 'yaml'
require 'matrix'

module Preflight
  module Rules

    #
    # * CLASSE DE VALIDAÇÃO ESPECÍFICA DAS CORES
    #
    # *Preto carregado (Preto K, misturado com todas as demais cores C, M e Y)
    # *Azul carregado (Azul com Cyan e Magenta igual ou superior a 99%)
    # *Laranja carregado(Amarelo com Yellow igual ou superior a 99% e Magenta em 60%)
    #
    
    class ColorValidator

      attr_reader :issues

      def page=(page)
        @issues = []
        @page    = page
        @objects = page.objects
      end

      def set_cmyk_color_for_nonstroking(c, m, y, k)
        check_ink(c, m, y, k)
      end

      def set_cmyk_color_for_stroking(c, m, y, k)
        check_ink(c, m, y, k)
      end

      private

      def check_ink(c, m, y, k)
        ink = (c + m + y + k) * 100.0
        cyan = c * 100.0
        magenta = m * 100.0
        yellow = y * 100.0
        black = k * 100.0
        average = ink / 4.0

        #Valida Preto carregado
        if 
          (black >= 85.0 && average >= 70.0) 
            @issues << Issue.new("A cor preta está carregada", self, 
              :page    => @page.number,
              :cyan    => c,
              :magenta => m,
              :yellow  => y,
              :k      => k)
        #Valida Azul carregado
        elsif
        (cyan >= 99.0 && magenta >= 99.0 && average <= 50.0) 
            @issues << Issue.new("A cor azul está carregada", self, 
              :page    => @page.number,
              :cyan    => c,
              :magenta => m,
              :yellow  => y,
              :k      => k)
        #Valida o Laranja carregado
        elsif
        (magenta >= 60.0 && yellow >= 99.0 && average <= 40.0) 
            @issues << Issue.new("A cor laranja está carregada", self, 
              :page    => @page.number,
              :cyan    => c,
              :magenta => m,
              :yellow  => y,
              :k      => k)
        end
      end
    end

  end
end
