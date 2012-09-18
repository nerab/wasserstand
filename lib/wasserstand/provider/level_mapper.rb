module Wasserstand
  module PegelOnline
=begin
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
=end
    class LevelMapper
      class << self
        def map(item)
          level_name = item.xpath('pegelname').text

          Level.new(level_name).tap do |pegel|
            # The level class will resolve the name to a real object if required
            pegel.waterway = item.xpath('../name').text

            pegel.level_id = item.xpath('pegelnummer').text
            pegel.km = item.xpath('km').text.sub(',', '.').to_f
            datum = item.xpath('datum').text
            uhrzeit = item.xpath('uhrzeit').text

            messdatum = TZInfo::Timezone.get('Europe/Berlin').local_to_utc(Time.parse("#{datum} #{uhrzeit}"))
            wert = item.xpath('messwert').text.sub(',', '.').to_f
            tendenz = item.xpath('tendenz').text

            pegel.measurements << Measurement.new(messdatum, wert, Trend.new(tendenz))
          end
        end
      end
    end
  end
end
