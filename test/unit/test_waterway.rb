require 'helper'

class TestWaterway < WasserstandTestCase
  def test_waterway_finder
    assert_equal(['ELBE', 'ELBE-HAVEL-KANAL', 'ELBESEITENKANAL'], Waterway.find_by_name('ELB.*').map{|w| w.name})
    assert_equal(7, Waterway.find_by_name('^E').size)
  end

  def test_size
    assert_equal(77, Waterway.all.size)
  end

  def test_waterway_levels
    assert_equal(1, Waterway['BODENSEE'].levels.size)
  end

  def test_lookup
    assert(Waterway['Elbe'].levels['Pirna'])
    assert(Waterway['ELBE-HAVEL-KANAL'].levels['GENTHIN'])
  end
end
