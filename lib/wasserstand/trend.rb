# -*- encoding: utf-8 -*-
module Wasserstand
  # http://blog.steveklabnik.com/posts/2012-09-09-random-ruby-tricks--class-new
  IllegalValueError = Class.new(StandardError)

  class Trend
    def initialize(value)
      @value = {'gleich'   => :gleichbleibend,
                'steigend' => :steigend,
                'fallend'  => :fallend}[UnicodeUtils.downcase(value.to_s)]

      raise IllegalValueError, "Unknown trend #{value.inspect}" unless @value
    end

    def symbol
      {:gleichbleibend => '⬄', :steigend => '⬀', :fallend => '⬂'}[@value]
    end

    def to_s
      @value.to_s
    end
  end
end
