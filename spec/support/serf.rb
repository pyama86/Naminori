class SerfStub
  class << self
    def exists_member
      members = <<EOS
lb001.dev.local   192.168.78.10:7946  alive  role=lb
dns001.dev.local  192.168.78.12:7946  alive  role=dns
EOS
      members.split("\n")
    end

    def not_exists_member
      members = <<EOS
lb001.dev.local   192.168.78.10:7946  alive  role=lb
EOS
      members.split("\n")
    end
  end
end
