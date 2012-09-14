module Wasserstand
  #
  # see http://www.pegelonline.wsv.de/gast/hilfe#hilfe_pegelparameter
  #
  class Level # Pegel
    attr_reader :id
    attr_accessor :name, :km, :measurements

    def initialize(id)
      @id = id
      @measurements = []
    end

    def to_s
      "#{@name} (km #{@km}): #{@measurements.last}"
    end
  end
end
