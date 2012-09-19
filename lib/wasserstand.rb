require 'nokogiri'
require 'open-uri'
require 'tzinfo'
require 'unicode_utils/upcase'
require 'unicode_utils/downcase'
require 'forwardable'

require 'require_all'
require_rel 'wasserstand'

module Wasserstand
  AmbigousNameError = Class.new(StandardError)

  class << self
    attr_writer :provider

    def provider
      @provider ||= Provider::PegelOnline.new
    end
  end
end
