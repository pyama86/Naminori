#! /usr/bin/env ruby
module Naminori
  class Notifier
    class Configure
      class << self
        def set(&block)
          instance_eval(&block)
        end

        def webhook_url(url=nil)
          @@_webhook_url = url if url
          @@_webhook_url
        end
        
        def channel(channel=nil)
          @@channel = channel if channel
          @@channel
        end

        def user(user=nil)
          @@user = user if user
          @@user
        end
      
        def clear
          class_variables.each do |v|
            class_variable_set(v, nil)
          end
        end
        

        def slack_enable?
          webhook_url && channel && user
        end
      end
    end
  end
end
