#! /usr/bin/env ruby
module Naminori
  class Lb
    class Lvs < Naminori::Lb::Base
      class << self
        def add_member(rip, service)
          transaction("add", lvs_option(rip, service)) if service.healty?(rip)
        end

        def delete_member(rip, service)
          transaction("delete", lvs_option(rip, service))
        end

        def transaction(type, ops)
          ops[:protocols].collect do |protocol|
            merge_option =  ops.merge({ protocol: protocol })
            if self.send("#{type}?", merge_option) && system("ipvsadm #{command_option(type, merge_option)}")
              notifier(type, merge_option)
              true
            end
          end.all? {|res| res }
        end

        def add?(ops)
          exist_vip?(ops) && !delete?(ops)
        end

        def delete?(ops)
          exist_ip?(ops, ops[:rip])
        end

        def exist_vip?(ops)
          exist_ip?(ops, ops[:vip])
        end

        def exist_ip?(ops, ip)
          fetch_service(ops).find do |line|
            line.match(/#{ip}/)
          end
        end

        def fetch_service(ops)
          service = `ipvsadm -Ln --#{ops[:protocol]}-service #{ops[:vip]}:#{ops[:port]}`.split("\n")
          raise "fetch errror!" unless service
          service
        end

        def lvs_option(rip, service)
          { service: service, vip: service.config.vip, rip: rip, protocols: service.config.protocols, port: service.config.port, method: service.config.method }
        end

        def command_option(type, ops)
          case
          when type == "add"
            "--#{type}-server --#{ops[:protocol]}-service #{ops[:vip]}:#{ops[:port]} -r #{ops[:rip]}:#{ops[:port]} #{method_option(ops[:method])}"
          when type == "delete"
            "--#{type}-server --#{ops[:protocol]}-service #{ops[:vip]}:#{ops[:port]} -r #{ops[:rip]}:#{ops[:port]}"
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
