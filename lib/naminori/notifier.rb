#! /usr/bin/env ruby
module Naminori
  class Notifier
    class << self
      def get_notifier(notifier)
        case notifier
        when "slack"
          Naminori::Notifier::Slack
        end
      end
    end
  end
end
