#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Configure
      def clear
        instance_variables.each do |v|
          instance_variable_set(v, nil)
        end
      end

      def slack_enable?
        webhook_url && channel && user
      end

      def webhook_url(url=nil)
        @_webhook_url = url if url
        @_webhook_url
      end
      
      def channel(channel=nil)
        @_channel = channel if channel 
        @_channel
      end

      def user(user=nil)
        @_user = user if user 
        @_user
      end
    end
  end
end
