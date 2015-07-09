#! /usr/bin/env ruby
module Naminori
  class Notifier
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

  def self.notify_config(&block)
    @_notify_config ||= Naminori::Notifier::Configure.new
    @_notify_config.instance_eval(&block) if block
    @_notify_config
  end
end
