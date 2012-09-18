# -*- encoding: utf-8 -*-
require 'helper'

class TestTrend < WasserstandTestCase

  def test_create_unknown
    assert_raises(ArgumentError){Trend.new}
    assert_raises(IllegalValueError){Trend.new(nil)}
    assert_raises(IllegalValueError){Trend.new('foobar')}
    assert_raises(IllegalValueError){Trend.new(:foobar)}
  end

  def test_create_gleich
    assert_trend_gleich(Trend.new('gleich'))
    assert_trend_gleich(Trend.new('Gleich'))
    assert_trend_gleich(Trend.new('GLEICH'))
    assert_trend_gleich(Trend.new(:gleich))
  end

  def test_create_steigend
    assert_trend_steigend(Trend.new('steigend'))
    assert_trend_steigend(Trend.new('Steigend'))
    assert_trend_steigend(Trend.new('STEIGEND'))
    assert_trend_steigend(Trend.new(:steigend))
  end

  def test_create_fallend
    assert_trend_fallend(Trend.new('fallend'))
    assert_trend_fallend(Trend.new('Fallend'))
    assert_trend_fallend(Trend.new('FALLEND'))
    assert_trend_fallend(Trend.new(:fallend))
  end

  def test_mapped
    assert_trend_gleich(Waterway['BODENSEE'].levels['KONSTANZ'].measurements.last.trend)
    assert_trend_steigend(Waterway['Oder'].levels['SCHWEDT-ODERBRÜCKE'].measurements.last.trend)
    assert_trend_fallend(Waterway['Elbe'].levels['STADERSAND'].measurements.last.trend)
  end

  private

  def assert_trend_gleich(trend)
    assert(trend)
    assert_equal('⬄', trend.symbol)
    assert_equal('gleichbleibend', trend.to_s)
  end

  def assert_trend_fallend(trend)
    assert(trend)
    assert_equal('⬂', trend.symbol)
    assert_equal('fallend', trend.to_s)
  end

  def assert_trend_steigend(trend)
    assert(trend)
    assert_equal('⬀', trend.symbol)
    assert_equal('steigend', trend.to_s)
  end
end
