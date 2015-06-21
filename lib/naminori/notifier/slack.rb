#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def send(type, message)
        icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping  icon + message, icon_emoji: ":sparkle:"
      rescue => e
        p e
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
