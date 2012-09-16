require 'helper'

class TestMeasurement < WasserstandTestCase
  def test_single
    konstanz_measurements = Waterway['BODENSEE'].levels['KONSTANZ'].measurements

    assert_equal(Time.parse('2012-09-13 18:00:00 UTC'), konstanz_measurements.last.date)
    assert_equal(380.7, konstanz_measurements.last.value)
    assert_equal(:gleich, konstanz_measurements.last.trend)
  end
end
