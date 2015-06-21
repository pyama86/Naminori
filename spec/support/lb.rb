class LbStub
  class << self
    def unregistered_vip
      ips = <<EOS
<<EOS
  IP Virtual Server version 1.2.1 (size=4096)
  Prot LocalAddress:Port Scheduler Flags
    -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
EOS
      ips.split("\n")
    end

    def unregistered_rip
      ips = <<EOS
  IP Virtual Server version 1.2.1 (size=4096)
  Prot LocalAddress:Port Scheduler Flags
    -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
  TCP  192.168.77.9:53 rr
  UDP  192.168.77.9:53 rr
EOS
      ips.split("\n")
    end

    def registered_rip
      ips = <<EOS
  IP Virtual Server version 1.2.1 (size=4096)
  Prot LocalAddress:Port Scheduler Flags
    -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
  TCP  192.168.77.9:53 rr
    -> 192.168.78.12:53             Route   1      0          0
  UDP  192.168.77.9:53 rr
    -> 192.168.78.12:53             Route   1      0          0
EOS
      ips.split("\n")
    end
  end
end
