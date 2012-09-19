# -*- encoding: utf-8 -*-
require 'helper'

class TestWaterway < WasserstandTestCase
  def test_size
    assert_equal(77, Waterway.all.size)
  end

  def test_levels
    assert_equal(1, Waterway['BODENSEE'].levels.size)
  end

  def test_lookup
    assert(Waterway['Elbe'].levels['Pirna'])
    assert(Waterway['ELBE-HAVEL-KANAL'].levels['GENTHIN'])
  end

  def test_lookup_umlaut
    assert(Waterway['Küstenkanal'])
    assert(Waterway['Elbe'].levels['Schöna'])
  end
end
