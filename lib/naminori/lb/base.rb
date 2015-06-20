#! /usr/bin/env ruby
module Naminori
  class Lb
    class Base
      class << self
        def add_member(rip, service)
          raise "Called abstract method: add_member"
        end
        def delete_member(rip, service)
          raise "Called abstract method: add_member"
        end
      end
    end
  end
end
