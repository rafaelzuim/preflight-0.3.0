# coding: utf-8

module Preflight
  module Profiles
    class PDFX1A
      include Preflight::Profile

      profile_name "pdfx-1a"
      
      rule Preflight::Rules::MatchInfoEntries, {:GTS_PDFXVersion => /\APDF\/X/,
                                                :GTS_PDFXConformance => /\APDF\/X-1a/}
      rule Preflight::Rules::RootHasKeys, :OutputIntents
      rule Preflight::Rules::InfoHasKeys, :Title, :CreationDate, :ModDate
      rule Preflight::Rules::InfoSpecifiesTrapping
      rule Preflight::Rules::CompressionAlgorithms, :ASCII85Decode, :CCITTFaxDecode, :DCTDecode, :FlateDecode, :RunLengthDecode
      rule Preflight::Rules::DocumentId
      rule Preflight::Rules::NoFilespecs
      rule Preflight::Rules::NoTransparency
      rule Preflight::Rules::OnlyEmbeddedFonts
      rule Preflight::Rules::BoxNesting
      rule Preflight::Rules::PrintBoxes
      rule Preflight::Rules::OutputIntentForPdfx
      rule Preflight::Rules::PdfxOutputIntentHasKeys, :OutputConditionIdentifier, :Info
      #Valida cores carregadas
      rule Preflight::Rules::MaxInkDensity, 250
      #Valida presença de RGB
      rule Preflight::Rules::NoRgb

    end
  end
end
