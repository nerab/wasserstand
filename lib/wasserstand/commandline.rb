module Wasserstand
  module Commandline
    def self.get(params = [])
      case params.size
      when 0
        present_waterway(Wasserstand::Waterway.all)
      when 1 # "Elbe" or "Dresden"
        waterway = Wasserstand::Waterway[params.first]

        if waterway
          present_waterway(waterway)
        else
          # not a waterway, treat it as level
          present_level(Wasserstand::Level[params.first])
        end
      when 2 # "Elbe Dresden" or "Ilm Ilmenau"
        if waterway = Wasserstand::Waterway[params.first]
          present_level(waterway.levels[params.last])
        else
          STDERR.puts "No matching waterway found."
        end
      else
        raise "Unexpected number of parameters."
      end
    end

    private

    def self.present_waterway(waterway, dig = true)
      if waterway.nil?
        STDERR.puts "No matching waterway found."
      else
        if waterway.respond_to?(:each)
          STDERR.puts "The following waterways are available:"
          waterway.each{|w| present_waterway(w, false)}
        else
          if !dig
            puts waterway.name
          else
            STDERR.puts "#{waterway.name} has #{waterway.levels.size} levels:"
            present_level(waterway.levels.values)
          end
        end
      end
    end

    def self.present_level(level, dig = true)
      if level.nil?
        STDERR.puts "No matching level found."
      else
        if level.respond_to?(:each)
          level.each{|l| present_level(l, false)}
        else
          if !dig
            puts level.name
          else
            STDERR.puts "#{level.name} (#{level.waterway}, km #{level.km}):"
            present_measurement(level.measurements)
          end
        end
      end
    end

    def self.present_measurement(measurement)
      if measurement.nil?
        STDERR.puts "No measurement found."
      else
        if measurement.respond_to?(:each)
          measurement.each{|l| present_measurement(l)}
        else
          puts measurement
        end
      end
    end
  end
end
