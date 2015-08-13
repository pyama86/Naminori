#! /usr/bin/env ruby
module Naminori
  class Service
    class Http < Naminori::Service::Base

      def healty?(ip)
        http = Net::HTTP.new(ip, config.port)
        http.open_timeout = config.timeout

        begin
          http.get("/#{config.query}")
        rescue
          false
        end
      end

      def default_config
        {
          lb:         "lvs",
          role:       "http",
          port:       "80",
          protocol:   "tcp",
          vip:        "192.168.77.9",
          method:     "nat",
          query:      "index.html",
          retry_c:    3,
          timeout:    3
        }
      end
    end
  end
end
