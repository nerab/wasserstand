module Wasserstand
  class Waterway
    class << self
      def [](name)
        Wasserstand.provider[name]
      end
    end

    attr_reader :name, :levels

    def initialize(name)
      @name = name
      @levels = {}
    end
  end
end
