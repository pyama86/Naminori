#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Base
      attr_reader :config
      def initialize()
        @config = Naminori::Notifier::Configure
      end

      def notifier(type, message)
        raise "Called abstract method: add_server"
      end
    end
  end
end
