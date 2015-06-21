#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def add_server(message)
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping message
      end

      def delete_server(message)
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping message
      end

      def default_config
        {
          webhook_url: "",
          channel: "general",
          user: "naminori-notifier"
        }
      end
    end
  end
end
