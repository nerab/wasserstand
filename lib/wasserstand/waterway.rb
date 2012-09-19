module Wasserstand
  # http://stackoverflow.com/questions/2030336/how-do-i-create-a-hash-in-ruby-that-compares-strings-ignoring-case
  class HashClod < Hash
    def [](key)
      key.respond_to?(:upcase) ? super(UnicodeUtils.upcase(key)) : super(key)
    end

    def []=(key, value)
      key.respond_to?(:upcase) ? super(UnicodeUtils.upcase(key), value) : super(key, value)
    end
  end

  class Waterway
    class << self
      def [](name)
        provider[name]
      end

      def all
        provider.all
      end

      def find_by_name(regex)
        provider.find_by_name(regex)
      end

      private

      def provider
        Wasserstand.providers[PegelOnline::WaterwayProvider]
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
  end
end
