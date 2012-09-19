require 'minitest/autorun'
require 'wasserstand'

class WasserstandTestCase < MiniTest::Unit::TestCase
  include Wasserstand

  def setup
    url = File.join(File.dirname(__FILE__), 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.providers[PegelOnline::WaterwayProvider] = PegelOnline::WaterwayProvider.new(url)
    Wasserstand.providers[PegelOnline::LevelProvider] = PegelOnline::LevelProvider.new(url)
  end
end
