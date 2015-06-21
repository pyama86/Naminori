#! /usr/bin/env ruby
module Naminori
  class Service
    class Dns < Naminori::Service::Base

      def healty?(ip)
        dns = Resolv::DNS.new(:nameserver => ip )
        dns.timeouts = config.timeout
        begin
          dns.getaddress(@config.query)
        rescue => e
          false
        end
      end

      def default_config
        {
          role: "dns",
          port: "53",
          protocol: ["udp", "tcp"],
          vip: "192.168.77.9",
          method: "gateway",
          query: "pepabo.com",
          retry: 3,
          timeout: 3,
          notifier: nil
        }
      end
    end
  end
end
