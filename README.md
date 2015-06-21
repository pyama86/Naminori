# Naminori
[![Build Status](https://travis-ci.org/pyama86/Naminori.svg)](https://travis-ci.org/pyama86/Naminori)
[![Code Climate](https://codeclimate.com/github/pyama86/Naminori/badges/gpa.svg)](https://codeclimate.com/github/pyama86/Naminori)
[![Test Coverage](https://codeclimate.com/github/pyama86/Naminori/badges/coverage.svg)](https://codeclimate.com/github/pyama86/Naminori/coverage)

Library to manage the load balancer using the Serf

## Installation

```ruby
gem 'naminori'
```

Or install it yourself as:

    $ gem install naminori

## Usage

### exemple

####  envent_example.rb
```ruby
#! /usr/bin/env ruby
require 'rubygems'
require 'naminori'

notifier_options = {
  webhook_url: "https://hooks.slack.com/services/XXXXXX",
  channel: "#pyama"
}

service_options = {
  vip:"192.168.77.9",
  role: "dns",
  notifier: Naminori::Notifier.get_notifier("slack" ,notifier_options)
}

case
when Naminori::Serf.role?("dns")
  Naminori::Service.event("dns", "lvs", service_options)
when Naminori::Serf.role?("lb")
  Naminori::Lb.health_check("dns", "lvs",service_options)
end

```

#### health_check_example.rb
```ruby
#! /usr/bin/env ruby
require 'rubygems'
require 'naminori'

service_options = { vip:"192.168.77.9", role: "dns" }

Naminori::Lb.health_check("dns", "lvs", service_options)
```
```zsh
# crontab -l
# Chef Name: health_check
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
* * * * * for i in `seq 0 10 59`;do (sleep ${i}; /opt/serf/event_handlers/health_check_example.rb)& done;
```




#### Service Event
```
Naminori::Service.event(service_name, lb_name, options)
```
* service_name:
  dns or http
* lb_name:
  lvs
* options(dns_default)
```
        {
          role: "dns",              # role name
          port: "53",               # service port
          protocol: ["udp", "tcp"], # protocol(array)
          vip: "192.168.77.9",      # service vip
          method: "gateway",        # lvs_method gateway/ip/nat
          query: "pepabo.com",      # health_check_query
          retry: 3,                 # health_check_retry_count
          timeout: 3,               # health_check_time_out
          notifier: nil             # notifier
        }
```
## Author
* pyama
