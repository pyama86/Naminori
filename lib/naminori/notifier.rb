#! /usr/bin/env ruby
module Naminori
  module Notifier
    class << self
      def notify(type, message)
        return true unless Naminori.configure.notifier 
        Naminori.configure.notifier.all? do |config|
          Object.const_get("Naminori::Notifier::#{config.type.to_s.capitalize}").notify(type, message, config)
        end 
      end
    end
  end
end
