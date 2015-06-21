#! /usr/bin/env ruby
module Naminori
  class Service
    class Configure
      attr_reader :webhook_url, :channel, :user
      def initialize(options)
        @webhook_url = options[:webhook_url]
        @channel     = options[:channel]
        @user        = options[:user]
      end
    end
  end
end
