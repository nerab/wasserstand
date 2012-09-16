module Wasserstand
  #
  # see http://www.pegelonline.wsv.de/gast/hilfe#hilfe_pegelparameter
  #
  class Level # Pegel
    class << self
      def [](name)
        Wasserstand.level_provider[name]
      end

      def all
        Wasserstand.level_provider.all
      end

      def find_by_name(regex)
        Wasserstand.level_provider.find_by_name(regex)
      end
    end

    attr_reader :name
    attr_accessor :level_id, :km, :measurements
    attr_writer :waterway

    def initialize(name)
      @name = name
      @measurements = []
    end

    def waterway
      if @waterway.respond_to?(:name)
        @waterway
      else
        @waterway = Waterway[@waterway]
      end
    end

    def to_s
      name
    end
  end
end
