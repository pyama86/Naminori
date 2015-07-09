#! /usr/bin/env ruby
module Naminori
  class Service
    class Http < Naminori::Service::Base

      def healty?(ip)
        http = Net::HTTP.new(ip, config.port)
        http.open_timeout = config.timeout

        begin
          http.get("/#{@query}")
        rescue => e
          false
        end
      end

      def default_config
        {
          role:       "http",
          port:       "80",
          protocols:  ["tcp"],
          vip:        "192.168.77.9",
          method:     "nat",
          query:      "index.html",
          retry:      3,
          timeout:    3
        }
      end
    end
  end
end
