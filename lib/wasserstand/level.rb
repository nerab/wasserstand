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
    end

    attr_reader :name

    #
    # Note that waterway is not always populated. It may have to be looked up externally.
    #
    attr_accessor :level_id, :km, :measurements, :waterway

    def initialize(name)
      @name = name
      @measurements = []
    end

    def to_s
      name
    end
  end
end
