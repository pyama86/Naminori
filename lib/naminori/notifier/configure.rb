#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Configure
      def self.attribute(name)
        define_method(name, ->(val=nil){
          @config ||= {}
          @config[name] = val if val
          @config[name]
        })
      end

      attribute :name
      attribute :webhook_url
      attribute :channel
      attribute :user
    end
  end
end
