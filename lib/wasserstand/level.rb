module Wasserstand
  #
  # see http://www.pegelonline.wsv.de/gast/hilfe#hilfe_pegelparameter
  #
  class Level
    class << self
      include Finders

      def all
        Wasserstand.provider.levels
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

    def inspect
      "#<#{self.class.name}: #{name} (#{measurements.size} measurements)>"
    end
  end
end
