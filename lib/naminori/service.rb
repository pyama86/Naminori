#! /usr/bin/env ruby
module Naminori
  class Service
    class << self
      def event(service_name, lb_name, options={})
        get_service(service_name).event(lb_name, options)
      end

      def get_service(service_name)
        case service_name
        when "dns"
          Naminori::Service::Dns
        when "http"
          Naminori::Service::Http
        end
      end
    end
  end
end
