#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def send(type, message)
        icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
        notifier = ::Slack::Notifier.new(
          Naminori::Notifier::Configure.webhook_url,
          {
            channel: Naminori::Notifier::Configure.channel, 
            username: Naminori::Notifier::Configure.user
          }
        )
        notifier.ping  icon + message, icon_emoji: ":sparkle:"
      rescue => e
        p e
      end
    end
  end
end
