require 'helper'

class TestLevel < WasserstandTestCase
  def test_size
    assert_equal(534, Level.all.size)
  end

  def test_kms
    elbe_levels = Waterway['ELBE'].levels
    assert_equal(60, elbe_levels.size)

    assert_level({:name => 'PIRNA', :km => 34.67, :measurements_size => 1}, elbe_levels['PIRNA'])
  end

  def test_lookup
    pirna = Level['Pirna']
    assert(pirna)
    assert(pirna.waterway)
    assert_equal('ELBE', pirna.waterway.name)

    assert(Level['GENTHIN'])
  end

  def test_ambigous_name
    assert_raises(Wasserstand::AmbigousNameError) do
      Level['Nienburg']
    end
  end

  private

  def assert_level(values, level)
    assert(level)
    assert_equal(values[:name], level.name)
    assert_equal(values[:km], level.km)
    assert_equal(values[:measurements_size], level.measurements.size)
  end
end
