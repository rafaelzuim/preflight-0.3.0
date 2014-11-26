# encoding: utf-8
#

require 'bigdecimal'

module Preflight
  module Measurements

    private

    # convert inches to standard PDF points
    #
    def in2pt(inch)
      return inch * BigDecimal.new("72")
    end

    # convert mm to standard PDF points
    #
    def mm2pt(mm)
      normalize = mm * (BigDecimal.new("72") / BigDecimal.new("25.4"))
      normalize = normalize.round(2)
      normalize = (normalize * 10).floor / 10.0
      return normalize
    end

    # convert mm to standard PDF points
    #
    def cm2pt(cm)
      return cm * mm2pt(10)
    end

    # convert standard PDF points to inches
    #
    def pt2in(pt)
      return pt / in2pt(1)
    end

    # convert standard PDF points to mm
    #
    def pt2mm(pt)
      mm = BigDecimal.new("72") / BigDecimal.new("25.4")
      normalize = pt / mm
      normalize = (normalize * 10).floor / 10.0
      return normalize
    end

    # convert standard PDF points to cm
    #
    def pt2cm(pt)
      return pt / cm2pt(1)
    end

    def mm2ptCrop(mm)
      return mm * (BigDecimal.new("72") / BigDecimal.new("25.4"))
    end
    
  end
end
