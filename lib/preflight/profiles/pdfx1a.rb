# coding: utf-8

module Preflight
  module Profiles
    class PDFX1A
      include Preflight::Profile

      profile_name "pdfx-1a"
      rule Preflight::Rules::MatchInfoEntries, {:GTS_PDFXVersion => /\APDF\/X/, :GTS_PDFXConformance => /\APDF\/X-1a/}
      rule Preflight::Rules::MaxVersion, 1.4
      rule Preflight::Rules::PageCount, 1
      rule Preflight::Rules::ColorValidator
      rule Preflight::Rules::NoRgb
      rule Preflight::Rules::OnlyEmbeddedFonts
      rule Preflight::Rules::NoTransparency
      rule Preflight::Rules::DocumentId

    end
  end
end
