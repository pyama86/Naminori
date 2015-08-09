#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Configure
      def initialize(type)
        @config ||= {}
        @config['type'] = type
      end

      def clear
        @config = nil
      end

      def slack_enable?
        %w(webhook_url channel user).all? {|c| @config[c.to_sym] } if @config
      end
      
      def self.attribute(name)
        define_method(name, ->(val=nil){
          @config[name] = val if val
          @config[name]
        })
      end

      attribute :webhook_url
      attribute :channel
      attribute :user
    end
  end
end
