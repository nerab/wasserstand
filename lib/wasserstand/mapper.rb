module Wasserstand
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
  class Mapper
    class << self
      def map(node)
        Waterway.new(node.xpath('name').text) .tap do |g|
          node.xpath('item').each do |item|
            id   = item.xpath('pegelnummer').text
            name = item.xpath('pegelname').text
            km   = item.xpath('km').text

            g.pegel[name] = Pegel.new(id, name, km).tap do |pegel|
              messdatum = Time.now # TODO parse date from date and time elements
              pegel.messwerte << Messwert.new(messdatum, item.xpath('messwert').text, item.xpath('tendenz').text)
            end
          end
        end
      end
    end
  end
end
