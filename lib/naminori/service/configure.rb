#! /usr/bin/env ruby
module Naminori
  class Service
    class Configure
      attr_reader :service, :role, :port, :protocol, :vip, :method, :query, :retry, :timeout
      def initialize(options)
        @role     = options[:role]
        @port     = options[:port]
        @protocol = options[:protocol]
        @vip      = options[:vip]
        @method   = options[:method]
        @query    = options[:query]
        @retry    = options[:retry]
        @timeout  = options[:timeout]
      end
    end
  end
end
