# http://stackoverflow.com/questions/2030336/how-do-i-create-a-hash-in-ruby-that-compares-strings-ignoring-case
class HashClod < Hash
  def [](key)
    key.respond_to?(:upcase) ? super(UnicodeUtils.upcase(key)) : super(key)
  end

  def []=(key, value)
    key.respond_to?(:upcase) ? super(UnicodeUtils.upcase(key), value) : super(key, value)
  end
end
