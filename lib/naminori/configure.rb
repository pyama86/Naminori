module Naminori
  class Configure
    def self.resource(rname)
      define_method(rname, ->(name=nil, &block){
        name = name.to_s
        instance_variable_set("@#{rname}_configs", []) unless instance_variable_get("@#{rname}_configs")
        config = eval("Naminori::#{rname.capitalize}::Configure.new(\"#{name}\")")
        config.instance_eval(&block) if block
        eval("@#{rname}_configs") << config
        eval("@#{rname}_configs")
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
