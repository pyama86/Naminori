#! /usr/bin/env ruby
module Naminori
  module Notifier
    class << self
      def notify(type, message)
        case
        when configure && configure.slack_enable?
          get_notifier("slack").notify(type, message)
        end
      end

      def get_notifier(notifier)
        case notifier
        when "slack"
          Naminori::Notifier::Slack
        end
      end

      def configure(&block)
        @_config ||= Naminori::Notifier::Configure.new
        @_config.instance_eval(&block) if block
        @_config
      end
    end
  end
end
