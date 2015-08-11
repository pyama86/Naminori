module Naminori
  class Configure
    def self.resource(resource_name)
      define_method(resource_name, ->(name=nil, &block){
        @_config ||= {}
        @_config[resource_name] ||= []
        if name
          config = Object.const_get("Naminori::#{resource_name.capitalize}::Configure").new
          config.name(name)
          config.instance_eval(&block) if block
          @_config[resource_name] << config
        end
        @_config[resource_name] << config
      })
    end

    resource :service
    resource :notifier
    resource :lb
  end

  def self.configure(&block)
    @__config ||= Configure.new
    @__config.instance_eval(&block) if block
    @__config
  end
end
