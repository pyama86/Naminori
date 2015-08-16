require 'spec_helper'
describe Naminori do
  before do
    Naminori.configure do |config|
      config.notifier :slack do
        webhook_url "https://hooks.slack.com/services/XXXXXX"
        channel     "#pyama"
        user        "#naminori"
      end

      config.service :dns_role do
        service :dns
      end
    end
  end

  describe 'event' do
    before do
      allow(Naminori::Serf).to receive(:members).and_return(SerfStub.exists_member)
      allow_any_instance_of(Slack::Notifier).to receive(:ping).and_return(true)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe 'member-join' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
        allow(Naminori::Serf).to receive(:join?).and_return(true)
        allow(STDIN).to receive(:gets).and_return(SerfStub.event)
        
        expect(Naminori::Lb::Lvs).to receive(:add_member).once
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
      end

      it do
        Naminori::Service::Dns.new(
          Naminori.configure.service.find {|config|config.service == :dns}
        ).run
      end
    end

    describe 'member-leave' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
        allow(Naminori::Serf).to receive(:leave?).and_return(true)
        allow(STDIN).to receive(:gets).and_return(SerfStub.event)

        expect(Naminori::Lb::Lvs).to receive(:add_member).never
        expect(Naminori::Lb::Lvs).to receive(:delete_member).once
      end

      it do
        Naminori::Service::Dns.new(
          Naminori.configure.service.find {|config|config.service == :dns }
        ).run
      end
    end
  end

  describe 'helth_check' do
    before do
      allow(Naminori::Serf).to receive(:members).and_return(SerfStub.exists_member)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe "good" do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
        
        expect(Naminori::Lb::Lvs).to receive(:add_member).once
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
      end

      it 'good health' do
        Naminori.health_check(Naminori::Service::Dns.new(
          Naminori.configure.service.find {|config|config.service == :dns }
        ))
      end
    end

    describe 'keep' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
        
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
      end

      it do
        Naminori.health_check(Naminori::Service::Dns.new(
          Naminori.configure.service.find {|config|config.service == :dns }
        ))
      end
    end

    describe 'bad health' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(false)
        
        expect(Naminori::Lb::Lvs).to receive(:add_member).never
        expect(Naminori::Lb::Lvs).to receive(:delete_member).once
      end

      it do
        Naminori.health_check(Naminori::Service::Dns.new(
          Naminori.configure.service.find {|config|config.service == :dns }
        ))
      end
    end
  end
end
