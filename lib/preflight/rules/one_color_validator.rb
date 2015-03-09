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
    
    class OneColorValidator

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
        
#Valida se existe UMA única cor (somente preta)
        if (c > 0.0 || m > 0.0 || y > 0.0)
            @issues << Issue.new(1, "colorview", "O verso do produto 4x1 deve ser somente preto.", self, 
              :page    => @page.number,
              :cyan    => c,
              :magenta => m,
              :yellow  => y,
              :k      => k)
        end
#Valida se existe somente UMA cor (independente de qual seja)
=begin     
        colors = [c, m, y, k]
        total  = 0

        colors.each do |color|
          if color > 0
            total += 1
          end
        end
        
        if total > 1
            @issues << Issue.new(1, "colorview", "O verso do produto 4x1 deve ter somente uma cor.", self, 
              :page    => @page.number,
              :cyan    => c,
              :magenta => m,
              :yellow  => y,
              :k      => k)
        end
=end
      end
    end

  end
end
