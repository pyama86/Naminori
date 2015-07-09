#! /usr/bin/env ruby
module Naminori
  class Lb
    class << self
      def get_lb(lb_name)
        case lb_name
        when "lvs"
          Naminori::Lb::Lvs
        end
      end
    end
  end
end
