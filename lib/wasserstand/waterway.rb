module Wasserstand
  class Waterway
    class << self
      include Wasserstand::Finders

      def all
        Wasserstand.provider.waterways
      end
    end

    attr_reader :name, :levels

    def initialize(name)
      @name = name
      @levels = HashClod.new
    end

    def to_s
      name
    end

    def inspect
      "#<#{self.class.name}: #{name} (#{levels.size} levels)>"
    end
  end
end
