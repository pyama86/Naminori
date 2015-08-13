#! /usr/bin/env ruby
require 'naminori'
module Naminori
  module Notifier
    class Configure
      extend Naminori::Attribute
      attr_accessor :config

      def initialize(name)
        type name
      end
      
      attribute :type
      attribute :webhook_url
      attribute :channel
      attribute :user
    end
  end
end
