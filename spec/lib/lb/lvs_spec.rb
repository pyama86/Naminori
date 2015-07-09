require 'spec_helper'
describe Naminori::Lb::Lvs do
  describe 'add member' do
    before do
      allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe 'ok' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
      end

      it do
        service = Naminori::Service::Dns.new({})
        options = Naminori::Lb::Lvs.lvs_option("192.168.78.12", service).merge({ protocol: "udp"})
        expect(Naminori::Lb::Lvs.command_option("add", options)).to eq "--add-server --udp-service 192.168.77.9:53 -r 192.168.78.12:53 -m"
        expect(Naminori::Lb::Lvs.add_member("192.168.78.12", service)).to eq true
      end
    end
    describe 'ng' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
      end

      it do
        service = Naminori::Service::Dns.new({})
        options = Naminori::Lb::Lvs.lvs_option("192.168.78.12", service).merge({ protocol: "tcp"})
        expect(Naminori::Lb::Lvs.command_option("add", options)).to eq "--add-server --tcp-service 192.168.77.9:53 -r 192.168.78.12:53 -m"
        expect(Naminori::Lb::Lvs.add_member("192.168.78.12", service)).to eq false 
      end
    end
  end

  describe 'delete member' do
    before do
      allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe 'ok' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
      end

      it do
        service = Naminori::Service::Dns.new({})
        options = Naminori::Lb::Lvs.lvs_option("192.168.78.12", service).merge({ protocol: "udp"})
        expect(Naminori::Lb::Lvs.command_option("delete", options)).to eq "--delete-server --udp-service 192.168.77.9:53 -r 192.168.78.12:53"
        expect(Naminori::Lb::Lvs.delete_member("192.168.78.12", service)).to eq true
      end
    end
    describe 'ng' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
      end

      it do
        service = Naminori::Service::Dns.new({})
        options = Naminori::Lb::Lvs.lvs_option("192.168.78.12", service).merge({ protocol: "tcp"})
        expect(Naminori::Lb::Lvs.command_option("delete", options)).to eq "--delete-server --tcp-service 192.168.77.9:53 -r 192.168.78.12:53"
        expect(Naminori::Lb::Lvs.delete_member("192.168.78.12", service)).to eq false 
      end
    end
  end
end
