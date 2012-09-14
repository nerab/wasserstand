require 'helper'

class TestWasserstand < MiniTest::Unit::TestCase
  def setup
    url = File.join(File.dirname(__FILE__), '..', 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.provider = Provider::PegelOnline.new(url)
  end

  def test_plain
    assert Wasserstand::Waterway['BODENSEE']
  end
end
