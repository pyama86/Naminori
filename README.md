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
1. check the event classification
2. add or delete rip if these member-join or member-leave(faile)
3. health_check with fetch member

```ruby
#! /usr/bin/env ruby
require 'rubygems'
require 'naminori'

Naminori.configure do |config|
  config.notifier :slack do
    webhook_url "https://hooks.slack.com/services/XXXXXX"
    channel     "#pyama"
  end

  config.service :dns_server do
    service  :dns
    protocol "udp"
    vip      "192.68.77.9"
  end

  config.service :dns_server do
    service  :dns
    protocol "tcp"
    vip      "192.68.77.9"
  end
end

Naminori.run

```

#### example loadbarance serf config
```
{
  "event_handlers": [
    "/opt/serf/event_handlers/envent_example.rb"
  ],
  "interface": "enp0s9",
  "discover": "cache-dns",
  "tags": {
    "role": "lb_server"
  },
  "log_level": "debug"
}
```

#### example dns serf config
```
{
  "event_handlers": [

  ],
  "interface": "enp0s8",
  "discover": "cache-dns",
  "tags": {
    "role": "dns_server"
  }
}
```

```zsh
# crontab -l
# Chef Name: health_check
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
* * * * * for i in `seq 0 10 59`;do (sleep ${i}; /opt/serf/event_handlers/event_example.rb)& done;
```

### default parameter
#### DNS
```
{
  lb: "lvs"                  # lb type
  port: "53",                # service port
  protocol: "udp"            # protocol
  vip: "192.168.77.9",       # service vip
  method: "nat",             # lvs_method gateway/ip/nat
  query: "pepabo.com",       # health_check_query
  retry_c: 3,                # health_check_retry_c_count
  timeout: 3,                # health_check_time_out
}
```
#### HTTP
```
{
  lb:         "lvs",
  port:       "80",
  protocol:   "tcp",
  vip:        "192.168.77.9",
  method:     "nat",
  query:      "index.html",
  retry_c:    3,
  timeout:    3
}

```

## Author
* pyama
