#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Slack < Base
      class << self
        def notify(type, message)
          icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
          notifier = ::Slack::Notifier.new(
            Naminori::Notifier.configure.webhook_url,
            {
              channel: Naminori::Notifier.configure.channel, 
              username: Naminori::Notifier.configure.user
            }
          )
          notifier.ping  icon + message, icon_emoji: ":sparkle:"
        rescue => e
          p e
        end
      end
    end
  end
end
