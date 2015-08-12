#! /usr/bin/env ruby
module Naminori
  class Service
    class Configure
      extend Naminori::Attribute
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
      attribute :retry_num
      attribute :timeout
    end
  end
end
