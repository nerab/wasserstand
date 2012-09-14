module Wasserstand
  class Waterway
    class << self
      def [](name)
        Wasserstand.provider[name]
      end
    end

    attr_reader :name, :level

    def initialize(name)
      @name = name
      @level = {}
    end
  end
end
