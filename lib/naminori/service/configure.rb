#! /usr/bin/env ruby
module Naminori
  class Service
    class Configure
      def initialize(role)
        @config ||= {}
        @config['role'] = role
      end

      def self.attribute(name)
        define_method(name, ->(val=nil){
          @config[name] = val if val
          @config[name]
        })
      end

      attribute :service
      attribute :lb
      attribute :port
      attribute :protocols
      attribute :vip
      attribute :method
      attribute :query
      attribute :retry
      attribute :timeout
    end
  end
end
