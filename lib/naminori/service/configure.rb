#! /usr/bin/env ruby
module Naminori
  class Service
    class Configure
      extend Naminori::Attribute
      attr_accessor :config
      def initialize(name)
        role name
      end

      attribute :role
      attribute :service
      attribute :lb
      attribute :port
      attribute :protocols
      attribute :vip
      attribute :method
      attribute :query
      attribute :retry_c
      attribute :timeout
    end
  end
end
