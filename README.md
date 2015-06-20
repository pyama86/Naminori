# Naminori

Library to manage the load balancer using the Serf

## Installation

```ruby
gem 'naminori'
```

Or install it yourself as:

    $ gem install naminori

## Usage

### exemple

```ruby
#! /usr/bin/env ruby
require File.dirname(__FILE__) + '/naminori/naminori'

service_options = { vip:"192.168.77.9", role: "dns" }

case
when Naminori::Serf.role?("dns")
  Naminori::Service.get_service("dns").event("lvs", service_options)
when Naminori::Serf.role?("lb")
  Naminori::Lb.health_check("dns", "lvs",service_options)
end
```

## Author
* pyama

