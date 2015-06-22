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
          vip_exists?(ops) && !delete?(ops)
        end

        def delete?(ops)
          fetch_service(ops).each do |line|
            return true if line.match(/#{ops[:rip]}:/)
          end
          false
        end

        def vip_exists?(ops)
          vips = fetch_service(ops)
          vips.each do |line|
            return true if line.match(/#{ops[:vip]}:/)
          end if vips
          false
        end

        def fetch_service(ops)
          `ipvsadm -Ln --#{ops[:protocol]}-service #{ops[:vip]}:#{ops[:port]}`.split("\n")
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
