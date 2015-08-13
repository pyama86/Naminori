#! /usr/bin/env ruby
module Naminori
  class Serf
    @@event = nil

    class << self
      def gets
        @@event ||= STDIN.gets.chomp.match(/(?<node>.+?)\t(?<ip>.+?)\t(?<role>.+?)\t/)
      end

      def event_message
        puts "event:#{ENV['SERF_EVENT']} value:#{gets}"
      end

      def join?
        ENV['SERF_EVENT'] == 'member-join'
      end

      def leave?
        ENV['SERF_EVENT'] == 'member-leave'
      end

      def failed?
        ENV['SERF_EVENT'] == 'member-failed'
      end

      def role?(role)
        gets[:role] == role
      end

      def get_alive_member_by_role(role)
        members.map do |line|
          member = parse_member(line)
          target_role?(member, role) && alive?(member) ? member : nil
        end.compact if members
      end

      def target_role?(member, role)
        member[:role] == role
      end

      def alive?(member)
        member[:status] == "alive"
      end

      def members
        `serf members`.split("\n")
      end

      def parse_member(member)
        member.match(/(?<node>.+?)\s+(?<ip>.+?):[0-9]+\s+(?<status>\w+)+\s+role=(?<role>\w+)/)
      end
    end
  end
end
