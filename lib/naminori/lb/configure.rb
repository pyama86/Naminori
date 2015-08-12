#! /usr/bin/env ruby
module Naminori
  class Lb
    class Configure
      extend Naminori::Attribute
      def initialize(name)
        role name
      end

      attribute :role
      attribute :check
    end
  end
end
