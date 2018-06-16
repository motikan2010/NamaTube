require 'unf'

module Util::NormalizerUtil
  extend ActiveSupport::Concern

  def normalize(word)
    UNF::Normalizer.normalize(word, :nfkc)
  end

end