#! /usr/bin/env ruby
module Naminori
  class Notifier
    class << self
      def send(type, message)
        case
        when Naminori.notify_config.slack_enable?
          get_notifier("slack").send(type, message)
        end
      end

      def get_notifier(notifier)
        case notifier
        when "slack"
          Naminori::Notifier::Slack.new
        end
      end

      def configure(&block)
        Naminori.notify_config(&block)
      end
    end
  end
  
end
