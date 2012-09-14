module Wasserstand
  #
  # see http://www.pegelonline.wsv.de/gast/hilfe#hilfe_pegelparameter
  #
  class Level # Pegel
    attr_reader :name, :id, :km, :measurements

    def initialize(id, name, km)
      @id = id
      @name = name
      @km = km
      @measurements = []
    end

    def to_s
      "#{@name} (km #{@km}): #{@measurements.last}"
    end
  end
end
