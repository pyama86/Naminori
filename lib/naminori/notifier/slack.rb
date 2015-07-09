#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def notify(type, message)
        icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
        notifier = ::Slack::Notifier.new(
          Naminori.notify_config.webhook_url,
          {
            channel: Naminori.notify_config.channel, 
            username: Naminori.notify_config.user
          }
        )
        notifier.ping  icon + message, icon_emoji: ":sparkle:"
      rescue => e
        p e
      end
    end
  end
end
