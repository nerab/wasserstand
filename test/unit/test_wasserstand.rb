require 'helper'

class TestWasserstand < MiniTest::Unit::TestCase
  include Wasserstand

  def setup
    url = File.join(File.dirname(__FILE__), '..', 'fixtures', 'pegelstaende_neu.xml')
    Wasserstand.waterway_provider = PegelOnline::WaterwayProvider.new(url)
  end

  def test_plain
    assert Waterway['BODENSEE']
  end

  def test_size
    assert_equal(77, Waterway.all.size)
  end

  def test_levels_size
    assert_equal(534, Level.all.size)
  end

  def test_waterway_levels
    assert_equal(1, Waterway['BODENSEE'].levels.size)
  end

  def test_level_kms
    elbe_levels = Waterway['ELBE'].levels
    assert_equal(60, elbe_levels.size)

    assert_level({:name => 'PIRNA', :km => 34.67, :measurements_size => 1}, elbe_levels['PIRNA'])
  end

  def assert_level(values, level)
    assert(level)
    assert_equal(values[:name], level.name)
    assert_equal(values[:km], level.km)
    assert_equal(values[:measurements_size], level.measurements.size)
  end

  def test_level_lookup
    assert(Waterway['Elbe'].levels['Pirna'])
    assert(Level['Pirna'])
    assert(Waterway['ELBE-HAVEL-KANAL'].levels['GENTHIN'])
    assert(Level['GENTHIN'])
  end

  def test_single_measurement
    konstanz_measurements = Waterway['BODENSEE'].levels['KONSTANZ'].measurements

    assert_equal(Time.parse('2012-09-13 18:00:00 UTC'), konstanz_measurements.last.date)
    assert_equal(380.7, konstanz_measurements.last.value)
    assert_equal(:gleich, konstanz_measurements.last.trend)
  end
end
