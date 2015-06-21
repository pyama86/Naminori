#! /usr/bin/env ruby
module Naminori
  class Notifier
    class << self
      def get_notifier(notifier, options={})
        case notifier
        when "slack"
          Naminori::Notifier::Slack.new(options)
        end
      end
    end
  end
end
