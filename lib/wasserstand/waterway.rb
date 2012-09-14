module Wasserstand
  class Waterway
    class << self
      def [](name)
        provider[name]
      end
    end

    attr_reader :name, :pegel

    def initialize(name)
      @name = name
      @pegel = {}
    end
  end
end
