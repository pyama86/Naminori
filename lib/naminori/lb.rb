#! /usr/bin/env ruby
module Naminori
  class Lb
    class << self
      def health_check(service_name, lb_name, options={})
        service = Naminori::Service.get_service(service_name).new(options)
        members = Naminori::Serf.get_alive_member_by_role(service.config.role)

        members.each do |member|
          ip = member_ip(member)
          if service.healty?(ip)
            get_lb(lb_name).add_member(ip, service)
          elsif service.config.retry.times.all? { sleep 1; !service.healty?(ip) }
            get_lb(lb_name).delete_member(ip, service)
          end
        end if members
      end

      def get_lb(lb_name)
        case lb_name
        when "lvs"
          Naminori::Lb::Lvs
        end
      end

      def member_ip(member)
        member[:ip]
      end
    end
  end
end
