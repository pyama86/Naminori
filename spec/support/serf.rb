class SerfStub
  class << self
    def exists_member
      members = <<EOS
lb001.dev.local   192.168.78.10:7946  alive  role=lb
dns001.dev.local  192.168.78.12:7946  alive  role=dns
http001.dev.local  192.168.78.12:7946  alive  role=http
EOS
      members.split("\n")
    end

    def not_exists_member
      members = <<EOS
lb001.dev.local   192.168.78.10:7946  alive  role=lb
EOS
      members.split("\n")
    end

    def event
      "dns001.dev.local\t192.168.78.12\tdns\trole=dns\n"
    end
  end
end
