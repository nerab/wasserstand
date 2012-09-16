require 'helper'

class TestLevel < WasserstandTestCase
  def test_size
    assert_equal(534, Level.all.size)
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

  def test_lookup
    assert(Level['Pirna'])
    assert(Level['GENTHIN'])
  end
end
