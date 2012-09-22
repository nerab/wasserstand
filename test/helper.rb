require 'minitest/autorun'
require 'wasserstand'

class WasserstandTestCase < MiniTest::Unit::TestCase
  include Wasserstand

  def setup
    url = File.join(File.dirname(__FILE__), 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.provider = Provider::PegelOnline.new(url)
    Wasserstand.provider.cache = HeapCache.new
  end
end
