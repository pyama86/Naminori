#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Base
      class << self
        def notifier(type, message)
          raise "Called abstract method: add_server"
        end
      end
    end
  end
end
