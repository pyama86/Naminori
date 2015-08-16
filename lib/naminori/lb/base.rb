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
      
        def notify(type, rip, service)
          message = "#{type} member ip:#{rip} protocol:#{service.config.protocol} in vip:#{service.config.vip}"
          puts message
          Naminori::Notifier.notify(type, message)
        end
      end
    end
  end
end
