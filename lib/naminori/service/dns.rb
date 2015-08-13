#! /usr/bin/env ruby
module Naminori
  class Service
    class Dns < Naminori::Service::Base
      def healty?(ip)
        dns = Resolv::DNS.new(:nameserver => ip )
        dns.timeouts = config.timeout
        begin
          dns.getaddress(config.query)
        rescue
          false
        end
      end

      def default_config
        {
          lb:        "lvs",
          role:      "dns",
          port:      "53",
          protocol:  "udp",
          vip:       "192.168.77.9",
          method:    "nat",
          query:     "pepabo.com",
          retry_c:   3,
          timeout:   3
        }
      end
    end
  end
end
