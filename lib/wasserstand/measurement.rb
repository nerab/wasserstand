module Wasserstand
  class Measurement
    attr_reader :date, :value, :trend

    def initialize(date, value, trend)
      @date, @value, @trend = date, value, trend
    end

    def to_i
      @value
    end

    def to_s
      "#{@date.getlocal}: #{@value} cm, Trend #{@trend}"
    end
  end
end
