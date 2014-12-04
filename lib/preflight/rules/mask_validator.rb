# coding: utf-8

require 'yaml'
require 'matrix'

module Preflight
  module Rules

    #
    # * CLASSE DE VALIDAÇÃO DE MÁSCARAS PARA VERNIZ LOCAL
    #
    # *Regra: A máscara deve ter cor predominante preta, não devendo ser colorida
    #
    
    class MaskValidator

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
        
        #Valida se o preto sobressai sobre as demais cores
        if 
          (cyan > 0.0 || magenta > 0.0 || yellow > 0.0)
            @issues << Issue.new(1, "colorview", "A máscara deve ter somente a cor preta.", self, 
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
