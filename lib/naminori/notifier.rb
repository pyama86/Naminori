#! /usr/bin/env ruby
module Naminori
  class Notifier
    class << self
      def notifier(type, message)
        config = Naminori::Notifier::Configure.instance
        case
        when config.webhook_url && config.user && config.channel
          get_notifier("slack").notifier(type, message)
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
