#! /usr/bin/env ruby
module Naminori
  class Service
    class << self
      def event(service_name, lb_name, options={})
        Naminori::Service.get_service(service_name).event(lb_name, options)
      end

      def get_service(service_name)
        case service_name
        when "dns"
          Naminori::Service::Dns
        end
      end
    end
  end
end
