require 'nokogiri'
require 'open-uri'
require 'tzinfo'
require 'unicode_utils/upcase'
require 'unicode_utils/downcase'
require 'forwardable'
require 'log4r'
require 'require_all'

require_rel 'wasserstand'

module Wasserstand
  AmbigousNameError = Class.new(StandardError)

  class << self
    def provider
      if @provider.nil?
        provider = Provider::PegelOnline.new # go through attribute writer in order to log
      end
      @provider
    end

    def provider=(p)
      Wasserstand.logger.info "Using provider #{p}"
      @provider = p
    end

    def logger
      @logger ||= Log4r::Logger.new(self.name).tap do |logger|
        out = Log4r::Outputter.stderr
        out.formatter = Log4r::PatternFormatter.new(:pattern => "%l: %m")
        logger.outputters = out
        logger.level = Log4r::WARN
      end
    end
  end
end
