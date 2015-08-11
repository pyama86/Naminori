#! /usr/bin/env ruby
module Naminori
  class Lb
    class Configure
      def check(roles)
        @check_rols ||= []
        @check_roles << roles
      end
    end
  end
end
