#! /usr/bin/env ruby
module Naminori
  class Service
    class Base
      attr_reader :config
      class << self
        def event(lb_name, options)
          case
          when Naminori::Serf.join?
            Naminori::Lb.get_lb(lb_name).add_member(event_ip, self.new(options))
          when Naminori::Serf.leave? || Naminori::Serf.failed?
            Naminori::Lb.get_lb(lb_name).delete_member(event_ip, self.new(options))
          end
        end

        def event_ip
          Naminori::Serf.gets[:ip]
        end
      
        def health_check(lb_name, options={})
          service = self.new(options)
          members = Naminori::Serf.get_alive_member_by_role(service.config.role)

          members.each do |member|
            ip = member[:ip]
            if service.healty?(ip)
              Naminori::Lb.get_lb(lb_name).add_member(ip, service)
            elsif service.config.retry.times.all? { sleep 1; !service.healty?(ip) }
              Naminori::Lb.get_lb(lb_name).delete_member(ip, service)
            end
          end if members
        end
        
      end

      def initialize(options={})
        @config = Naminori::Service::Configure.new(
          default_config.merge(options)
        )
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
