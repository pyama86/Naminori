#! /usr/bin/env ruby
module Naminori
  class Lb
    class Base
      class << self
        def add_member(rip, service)
          raise "Called abstract method: add_member"
        end
        def delete_member(rip, service)
          raise "Called abstract method: add_member"
        end

        def notifier(type, options)
          message = "#{type} member ip:#{options[:rip]} protocol:#{options[:protocol]} in vip:#{options[:vip]}"
          puts message
          options[:service].config.notifier.send(type, message) if options[:service].config.notifier
        end
      end
    end
  end
end
