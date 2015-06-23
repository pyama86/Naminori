#! /usr/bin/env ruby
module Naminori
  class Notifier
    class << self
      def send(type, message)
        config = Naminori::Notifier::Configure.instance
        case
        when config.webhook_url && config.user && config.channel
          get_notifier("slack").send(type, message)
        end
      end

      def get_notifier(notifier)
        case notifier
        when "slack"
          Naminori::Notifier::Slack.new
        end
      end
    end
  end
end
