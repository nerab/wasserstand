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
    assert_equal(1, Waterway['BODENSEE'].levels.size)
  end

  def test_level_lookup
    assert(Waterway['BODENSEE'].levels['KONSTANZ'])
    assert(Waterway['ELBE-HAVEL-KANAL'].levels['GENTHIN'])
  end

  def test_single_measurement
    konstanz_measurements = Waterway['BODENSEE'].levels['KONSTANZ'].measurements

    assert_equal(Time.parse('2012-09-13 20:00:00 +0200'), konstanz_measurements.last.date)
    assert_equal(380.7, konstanz_measurements.last.value)
    assert_equal(:gleich, konstanz_measurements.last.trend)
  end
end
