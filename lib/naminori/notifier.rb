#! /usr/bin/env ruby
module Naminori
  module Notifier
    class << self
      def notify(type, message)
        Naminori.configure.notifier.each do |config|
          Object.const_get("Naminori::Notifier::#{config.type.to_s.capitalize}").notify(type, message, config)
        end if Naminori.configure.notifier 
      end
    end
  end
end
