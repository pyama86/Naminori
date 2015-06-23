#! /usr/bin/env ruby
require 'singleton'
module Naminori
  class Notifier
    class Configure
      include Singleton
      attr_reader :webhook_url, :channel, :user

      def set(options)
        @webhook_url = options[:webhook_url]
        @channel     = options[:channel]
        @user        = options[:user]
      end

      def enable?
        webhook_url && channel && user
      end
    end
  end
end
