#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Base
      def send(message, options)
        raise "Called abstract method: send"
      end
    end
  end
end
