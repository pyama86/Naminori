module Naminori
  module Attribute
    def attribute(name)
      define_method(name, ->(val=nil){
        @config ||= {}
        @config[name] = val if val
        @config[name]
      })
    end
  end
end
