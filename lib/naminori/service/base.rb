#! /usr/bin/env ruby
module Naminori
  class Service
    class Base
      attr_reader :config
      def initialize(config_klass)
        config_klass.config = default_config.merge(config_klass.config)
        @config = config_klass
      end

      def run
        if Naminori::Serf.role?(config.role.to_s)
          ip = Naminori::Serf.gets[:ip] 
          case
          when Naminori::Serf.join?
            Object.const_get("Naminori::Lb::#{config.lb.to_s.capitalize}").add_member(ip, self)
          when Naminori::Serf.leave? || Naminori::Serf.failed?
            Object.const_get("Naminori::Lb::#{config.lb.to_s.capitalize}").delete_member(ip, self)
          end
        end
      end
    
      def healty?(ip)
        raise "Called abstract method: healty?"
      end

      def default_config
        raise "Called abstract method: default_config"
      end
        
    end
  end
end
