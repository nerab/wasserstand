module Wasserstand
  class HeapCache
    def initialize
      @backend = {}
    end

    def get(name)
      result = @backend[name]
      Wasserstand.logger.debug "#{self.class.name} GET #{result ? 'HIT' : 'MISS'} #{name}"
      result
    end

    def set(name, value)
      Wasserstand.logger.debug "#{self.class.name} SET #{name} => #{value.inspect}"
      @backend[name] = value
    end
  end
end
