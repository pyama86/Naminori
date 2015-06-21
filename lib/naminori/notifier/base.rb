#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Base
      attr_reader :config
      def initialize(options={})
        @config = Naminori::Notifier::Configure.new(
          default_config.merge(options)
        )
      end

      def add_member(message)
        raise "Called abstract method: add_server"
      end

      def delete_member(message)
        raise "Called abstract method: delete_server"
      end

      def default_config
        raise "Called abstract method: default_config"
      end

    end
  end
end
