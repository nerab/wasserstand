# -*- encoding: utf-8 -*-
require 'helper'
require 'open3'

#
# End-to-end test
#
class TestApp < MiniTest::Unit::TestCase
  APP_SCRIPT = 'ruby bin/wasserstand'
  DEFAULT_OPTIONS = {
    'url' => File.join(File.dirname(__FILE__), '..', 'fixtures', 'pegelstaende_neu.xml')
  }

  def test_all_waterways
    stdout, stderr = execute
    assert_equal(77, stdout.size)
    assert_equal(["ILM\n", "ILMENAU\n", "ITTER ZUR DIEMEL\n", "ITTER ZUR EDER\n"], stdout.select{|name| name =~ /^I/i})
  end

  def test_waterway
    stdout, stderr = execute('Diemel')
    assert_equal(3, stdout.size)
    assert_equal(["DIEMELTALSPERRE\n", "HELMINGHAUSEN\n", "WILHELMSBRÜCKE\n"], stdout)
    assert_equal(["DIEMEL has 3 levels:\n"], stderr)
  end

  def test_unknown_waterway
    stdout, stderr = execute("Donaukanal")
    assert_equal(0, stdout.size)
    assert_equal(["No match found.\n"], stderr)
  end

  def test_level
    stdout, stderr = execute(['Cochem'])
    assert_equal(["2012-09-13 20:15:00 +0200: 221.0 cm, Trend fallend\n"], stdout)
    assert_equal(["COCHEM (MOSEL, km 51.6):\n"], stderr)
  end

  def test_level_with_waterway
    stdout, stderr = execute(['Ems', 'Knock'])
    assert_equal(["2012-09-13 22:31:00 +0200: 626.6 cm, Trend fallend\n"], stdout)
    assert_equal(["KNOCK (EMS, km 50.848):\n"], stderr)
  end

  def test_unknown_level
    stdout, stderr = execute("Altstadt")
    assert_equal(0, stdout.size)
    assert_equal(["No match found.\n"], stderr)
  end

  private

  def execute(params = [], options = {})
    line = []
    line << APP_SCRIPT
    line.concat(Array(params))
    line << DEFAULT_OPTIONS.merge(options).map do |k,v|
      if v.nil? || v.to_s.empty?
        "#{k}"
      else
        "--#{k}=#{v}"
      end
    end

    out = ''
    err = ''

    Open3.popen3(line.join(' ')) do |stdin, stdout, stderr|
      out << stdout.read
      err << stderr.read
    end

    return [out.lines.to_a, err.lines.to_a]
  end
end
