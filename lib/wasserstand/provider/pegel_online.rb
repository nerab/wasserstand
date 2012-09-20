module Wasserstand
  module Provider
    class PegelOnline
      attr_writer :cache

      include Enumerable
      extend Forwardable
      def_delegator :all, :each

      def initialize(url = 'http://www.pegelonline.wsv.de/svgz/pegelstaende_neu.xml')
        @url = url
        @names = []
      end

      # Cache entries may expire, and simply iterating over the list of current cache entries would render an incomplete picture. Therefore we maintain the knowledge of what waterways exist in a single list, which is the authoritative source of what waterways exist.
      def waterways
        replenish if @names.empty?
        @names.map do |name|
          ww = cache.get(name) # no fetch with block in Dalli, so we cannot use it here either ...

          # Not finding the Waterway for a name means it was removed from the cache, but it may or may not exist in the backend. Therefore we need to replenish our cache including our knowledge about the name.
          if ww.nil?
            replenish
            ww = cache.get(name)
            # Still nil? Does not matter. Replenish has auto-removed an outdated name.
          end

          ww
        end.compact # don't return nil entries
      end

      def levels
        waterways.inject([]){|result, ww| result.concat(ww.levels.values)}
      end

      def cache
        @cache ||= HeapCache.new
      end

      private

      #
      # Replenish the cache and names index
      #
      def replenish
        @names.clear
        Wasserstand.logger.info "Fetching #{@url}"
        doc = Nokogiri::HTML(open(@url).read, nil, 'ISO-8859-1')
        doc.xpath("//data/table/gewaesser").each do |node|
          ww = WaterwayMapper.map(node)
          @names << ww.name
          cache.set(ww.name, ww)
        end
      end
    end
  end
end
