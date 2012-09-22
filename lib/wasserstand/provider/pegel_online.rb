module Wasserstand
  module Provider
    class PegelOnline
      include Enumerable
      extend Forwardable
      def_delegator :all, :each

      def initialize(url = nil)
        @url = url || 'http://www.pegelonline.wsv.de/svgz/pegelstaende_neu.xml'
      end

      # Cache entries may expire, and simply iterating over the list of current cache entries would render an incomplete picture. Therefore we maintain the knowledge of what waterways exist in a single list, which is the authoritative source. If that one is gone, it is gone as a whole and everything will need to be refreshed.
      def waterways
        names = cache.get(KEY_NAMES) || replenish

        names.map do |name|
          ww = cache.get(name) # no fetch with block in Dalli, so we cannot use it here either ...

          # Not finding the Waterway for a name means it was removed from the cache, but it may or may not exist in the backend. Therefore we need to replenish our cache including our knowledge about the names.
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
        if @cache.nil?
          self.cache = HeapCache.new
        end
        @cache
      end

      def cache=(c)
        Wasserstand.logger.info "Using cache #{c}"
        @cache = c
      end

      def to_s
        "#<#{self.class.name}:#{@url}>"
      end

      private

      KEY_NAMES = "#{self.name}#names"

      #
      # Replenish the cache and names index
      #
      def replenish
        Wasserstand.logger.info "Fetching #{@url}"
        doc = Nokogiri::HTML(open(@url).read, nil, 'ISO-8859-1')

        names = []
        doc.xpath("//data/table/gewaesser").each do |node|
          ww = WaterwayMapper.map(node)
          cache.set(ww.name, ww)
          names << ww.name
        end
        cache.set(KEY_NAMES, names)
        names
      end
    end
  end
end
