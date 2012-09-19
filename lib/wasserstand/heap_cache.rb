class HeapCache
  def initialize
    @backend = {}
  end

  def get(name)
    result = @backend[name]
    STDERR.puts "#{self.class.name} GET #{result ? 'HIT' : 'MISS'} #{name}"
    result
  end

  def set(name, value)
    STDERR.puts "#{self.class.name} SET #{name} => #{value.inspect}"
    @backend[name] = value
  end
end
