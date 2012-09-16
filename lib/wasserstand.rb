require 'nokogiri'
require 'open-uri'
require 'tzinfo'

require 'require_all'
require_rel 'wasserstand'

module Wasserstand
  class << self
    attr_writer :waterway_provider, :level_provider

    def waterway_provider
      @waterway_provider ||= PegelOnline::WaterwayProvider.new
    end

    def level_provider
      @level_provider ||= PegelOnline::LevelProvider.new
    end
  end
end
