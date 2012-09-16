module Wasserstand
  module PegelOnline
=begin
      <gewaesser>
        <name>BODENSEE</name>
        <item>
          <no>8</no>
          <psmgr>320</psmgr>
          <pegelname>KONSTANZ</pegelname>
          <messwert>380,7</messwert>
          <km>0</km>
          <pnp>391,89</pnp>
          <tendenz>Gleich</tendenz>
          <datum>13.09.2012</datum>
          <uhrzeit>20:00:00</uhrzeit>
          <pegelnummer>0906</pegelnummer>
        </item>
      </gewaesser>
=end
    class WaterwayMapper
      class << self
        def map(node)
          Waterway.new(node.xpath('name').text).tap do |ww|
            node.xpath('item').each do |item|
              level = LevelMapper.map(item)
              level.waterway = ww
              ww.levels[level.name] = level
            end
          end
        end
      end
    end
  end
end
