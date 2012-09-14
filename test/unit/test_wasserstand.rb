require 'helper'

class TestWasserstand < MiniTest::Unit::TestCase
  include Wasserstand

  def setup
    url = File.join(File.dirname(__FILE__), '..', 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.provider = Provider::PegelOnline.new(url)
  end

  def test_plain
    assert Waterway['BODENSEE']
  end

  def test_levels
    assert_equal(1, Waterway['BODENSEE'].level.size)
  end
end
