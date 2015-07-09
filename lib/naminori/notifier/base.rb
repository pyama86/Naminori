#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Base
      class << self
        def notify(type, message)
          raise "Called abstract method: notify"
        end
      end
    end
  end
end
