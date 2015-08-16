#! /usr/bin/env ruby
module Naminori
  module Notifier
    class Slack
      class << self
        def notify(type, message, config)
          icon = type == "add" ? ":white_check_mark:" : ":no_entry_sign:"
          notifier = ::Slack::Notifier.new(
            config.webhook_url,
            {
              channel: config.channel, 
              username: config.user
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
