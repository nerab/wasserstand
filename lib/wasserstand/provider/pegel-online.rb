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

      def find_by_name(name_expression)
        # Not the best performing way, but it gives us the ability to use the  XPath 2.0 'matches' function
        # which isn't supported in Nokogiri (yet).
        Nokogiri::HTML(fetch(@url), nil, 'ISO-8859-1').xpath(xpath_finder(name_expression), Class.new{
          def matches(node_set, regex)
            node_set.find_all do |node|
              node.to_s.match(%r{#{regex}})
            end
          end
        }.new).map{|o| mapper.map(o)}
      end

      protected

      def xpath_lookup(name)
        "#{xpath_all}[#{name_attribute}/text() = '#{name.upcase}']"
      end

      def xpath_finder(regex)
        "#{xpath_all}[matches(#{name_attribute}/text(), '#{regex}')]"
      end

      def fetch(url)
        open(url).read
      end

      def name_attribute
        'name'
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

      def mapper
        Wasserstand::PegelOnline::LevelMapper
      end

      def name_attribute
        'pegelname'
      end
    end
  end
end
