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
        Waterway.new(node.xpath('name').text) .tap do |ww|
          node.xpath('item').each do |item|
            pegel_name = item.xpath('pegelname').text
            ww.levels[pegel_name] = Level.new(item.xpath('pegelnummer').text).tap do |pegel|
              pegel.name = pegel_name
              pegel.km = item.xpath('km').text

              datum = item.xpath('datum').text
              uhrzeit = item.xpath('uhrzeit').text

              messdatum = TZInfo::Timezone.get('Europe/Berlin').local_to_utc(Time.parse("#{datum} #{uhrzeit}"))
              wert = item.xpath('messwert').text.sub(',', '.').to_f
              tendenz = item.xpath('tendenz').text.downcase.to_sym

              pegel.measurements << Measurement.new(messdatum, wert, tendenz)
            end
          end
        end
      end
    end
  end
end
