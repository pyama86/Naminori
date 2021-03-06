require 'spec_helper'
describe Naminori::Lb::Lvs do
  before do
    Naminori.configure do |config|
      config.service :dns_role do
        service :dns
      end
    end
    @service = Naminori::Service::Dns.new(
      Naminori.configure.service.find {|config|config.service == :dns}
    )
  end

  describe 'add member' do
    before do
      allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe 'ok' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
        @service.config.protocol 'udp'
      end

      it do
        expect(Naminori::Lb::Lvs.command_option("add", "192.168.78.12", @service)).to eq "--add-server --udp-service 192.168.77.9:53 -r 192.168.78.12:53 -m"
        expect(Naminori::Lb::Lvs.add_member("192.168.78.12", @service)).to eq true
      end
    end
    describe 'ng' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        @service.config.protocol 'tcp'
      end

      it do
        expect(Naminori::Lb::Lvs.command_option("add", "192.168.78.12", @service)).to eq "--add-server --tcp-service 192.168.77.9:53 -r 192.168.78.12:53 -m"
        expect(Naminori::Lb::Lvs.add_member("192.168.78.12", @service)).to be_falsey
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
        @service.config.protocol 'udp'
      end

      it do
        expect(Naminori::Lb::Lvs.command_option("delete", "192.168.78.12", @service)).to eq "--delete-server --udp-service 192.168.77.9:53 -r 192.168.78.12:53"
        expect(Naminori::Lb::Lvs.delete_member("192.168.78.12", @service)).to eq true
      end
    end
    describe 'ng' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
        @service.config.protocol 'tcp'
      end

      it do
        expect(Naminori::Lb::Lvs.command_option("delete", "192.168.78.12", @service)).to eq "--delete-server --tcp-service 192.168.77.9:53 -r 192.168.78.12:53"
        expect(Naminori::Lb::Lvs.delete_member("192.168.78.12", @service)).to be_falsey
      end
    end
  end
end
