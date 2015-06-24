#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Slack < Base
      def notifier(type, message)
        icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
        notifier = ::Slack::Notifier.new(config.webhook_url, { channel: config.channel, username: config.user})
        notifier.ping  icon + Time.new.strftime("%H:%M:%S ") + message, icon_emoji: ":sparkle:"
      rescue => e
        p e
      end
    end
  end
end
