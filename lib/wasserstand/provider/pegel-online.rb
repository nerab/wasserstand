module Wasserstand
  module Provider
    class PegelOnline
      def initialize(url = 'http://www.pegelonline.wsv.de/svgz/pegelstaende_neu.xml')
        @url = url
      end

      def [](name)
        doc = Nokogiri::HTML(open(@url).read)
        results = doc.xpath("//data/table/gewaesser[name/text() = '#{name.upcase}']")

        case results.size
        when 0
          return nil # loookup returns nil if not found. This is a lookup, not find_all.
        when 1
          return Mapper.map(results.first)
        else
          raise "Found #{results.size} results for #{name}."
        end
      end
    end
  end
end
