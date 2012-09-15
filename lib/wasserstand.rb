require 'nokogiri'
require 'open-uri'
require 'tzinfo'

require 'require_all'
require_rel 'wasserstand'

module Wasserstand
  class << self
    attr_writer :provider

    def provider
      @provider ||= Provider::PegelOnline.new
    end
  end
end
