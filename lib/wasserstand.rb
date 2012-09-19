require 'nokogiri'
require 'open-uri'
require 'tzinfo'
require 'unicode_utils/upcase'
require 'unicode_utils/downcase'

require 'require_all'
require_rel 'wasserstand'

module Wasserstand
  class << self
    def providers
      @providers ||= Hash.new{|hash, k| hash[k] = k.new}
    end
  end
end
