#! /usr/bin/env ruby
module Naminori
  class Lb
    class Lvs < Naminori::Lb::Base
      class << self
        def add_member(rip, service)
          transaction("add", rip, service) if service.healty?(rip) && exist_ip?(service.config.vip, service) && !exist_ip?(rip, service)
        end

        def delete_member(rip, service)
          transaction("delete", rip, service) if exist_ip?(rip, service)
        end

        def transaction(type, rip, service)
          if system("ipvsadm #{command_option(type, rip, service)}")
            notify(type, rip, service)
          end
        end

        def exist_ip?(ip, service)
          fetch_service(service).find do |line|
            line.match(/#{ip}/)
          end
        end

        def fetch_service(service)
          unless result = `ipvsadm -Ln --#{service.config.protocol}-service #{service.config.vip}:#{service.config.port}`.split("\n")
            raise "fetch errror!"
          end
          result 
        end

        def command_option(type, rip, service)
          case
          when type == "add"
            "--#{type}-server --#{service.config.protocol}-service #{service.config.vip}:#{service.config.port} -r #{rip}:#{service.config.port} #{method_option(service.config.method)}"
          when type == "delete"
            "--#{type}-server --#{service.config.protocol}-service #{service.config.vip}:#{service.config.port} -r #{rip}:#{service.config.port}"
          end
        end

        def method_option(method)
          case
          when method == "gateway"
            "-g"
          when method == "nat"
            "-m"
          when method == "ip"
            "-i"
          end
        end
      end
    end
  end
end
