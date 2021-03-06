module Wasserstand
  module Finders
    def [](name)
      return nil if name.to_s.empty?
      results = all.select{|named| UnicodeUtils.upcase(name) == named.name}

      case results.size
      when 0
        nil # loookup returns nil if not found. This is a lookup, not find_all.
      when 1
        results.first
      else
        raise AmbigousNameError.new "Name '#{name}' is not unique. Found #{results.size} results."
      end
    end
  end
end
