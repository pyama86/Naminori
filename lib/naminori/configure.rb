module Naminori
  class Configure
    def initialize
        @_config ||= {}
    end

    def self.resource(resource_name)
      define_method(resource_name, ->(name=nil, &block){
        if name
          config = Object.const_get("Naminori::#{resource_name.capitalize}::Configure").new(name)
          config.instance_eval(&block) if block
          @_config[resource_name] ||= []
          @_config[resource_name] << config
        end
        @_config[resource_name]
      })
    end

    resource :service
    resource :notifier
    resource :lb
  end

  def self.configure(&block)
    if block
      @__config = Configure.new
      @__config.instance_eval(&block)
    end
    @__config
  end
end
