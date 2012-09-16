require 'minitest/autorun'
require 'wasserstand'

class WasserstandTestCase < MiniTest::Unit::TestCase
  include Wasserstand

  def setup
    url = File.join(File.dirname(__FILE__), 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.waterway_provider = PegelOnline::WaterwayProvider.new(url)
    Wasserstand.level_provider = PegelOnline::LevelProvider.new(url)
  end
end
