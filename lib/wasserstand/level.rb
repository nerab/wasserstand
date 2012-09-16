module Wasserstand
  #
  # see http://www.pegelonline.wsv.de/gast/hilfe#hilfe_pegelparameter
  #
  class Level # Pegel
    attr_reader :name
    attr_accessor :level_id, :km, :measurements, :waterway

    def initialize(name, waterway)
      @name = name
      @waterway = waterway
      @measurements = []
    end

    def to_s
      "#{@name} (#{@waterway}, km #{@km}): #{@measurements.last}"
    end
  end
end
