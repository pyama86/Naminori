require "naminori/version"
require "naminori/attribute"
require 'naminori/configure'
require 'naminori/serf'
require 'naminori/lb/base'
require 'naminori/lb/lvs'
require 'naminori/service/base'
require 'naminori/service/configure'
require 'naminori/service/dns'
require 'naminori/service/http'
require 'naminori/notifier'
require 'naminori/notifier/configure'
require 'naminori/notifier/slack'
require 'resolv'
require 'slack-notifier'


module Naminori
  def self.run
    Naminori.configure.service.each do |s|
      service = Object.const_get("Naminori::Service::#{s.service.to_s.capitalize}").new(s)
      service.run
      health_check(service)
    end if Naminori.configure.service
  end

  def self.health_check(service)
    if members = Naminori::Serf.get_alive_member_by_role(service.config.role.to_s)
      members.each do |member|
        ip = member[:ip]
        if service.healty?(ip)
          Object.const_get("Naminori::Lb::#{service.config.lb.to_s.capitalize}").add_member(ip, service)
        elsif service.config.retry_c.times.all? { sleep 1; !service.healty?(ip) }
          Object.const_get("Naminori::Lb::#{service.config.lb.to_s.capitalize}").delete_member(ip, service)
        end
      end
    end
  end

end
