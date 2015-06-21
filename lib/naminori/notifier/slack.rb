#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def add_server(message)
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping ":white_check_mark:" + message, icon_emoji: ":sparkle:"
      end

      def delete_server(message)
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping ":no_entry_sign:" + message, icon_emoji: ":sparkle:"
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
