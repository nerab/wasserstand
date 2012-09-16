module Wasserstand
  module PegelOnline
    class Provider
      def initialize(url = 'http://www.pegelonline.wsv.de/svgz/pegelstaende_neu.xml')
        @url = url
      end

      def [](name)
        doc = Nokogiri::HTML(fetch(@url), nil, 'ISO-8859-1')
        results = doc.xpath(xpath_lookup(name))

        case results.size
        when 0
          return nil # loookup returns nil if not found. This is a lookup, not find_all.
        when 1
          return mapper.map(results.first)
        else
          raise "Name is not unique. Found #{results.size} results for #{name}."
        end
      end

      def all
        Nokogiri::HTML(fetch(@url), nil, 'ISO-8859-1').xpath(xpath_all).map{|o| mapper.map(o)}
      end

      protected

      def xpath_lookup(name)
        "#{xpath_all}[name/text() = '#{name.upcase}']"
      end

      def fetch(url)
        open(url).read
      end
    end

    class WaterwayProvider < Provider
      def xpath_all
        "//data/table/gewaesser"
      end

      def mapper
        Wasserstand::PegelOnline::WaterwayMapper
      end
    end

    class LevelProvider < Provider
      def xpath_all
        "//data/table/gewaesser/item"
      end

      def xpath_lookup(name)
        "#{xpath_all}[pegelname/text() = '#{name.upcase}']"
      end

      def mapper
        Wasserstand::PegelOnline::LevelMapper
      end
    end
  end
end
