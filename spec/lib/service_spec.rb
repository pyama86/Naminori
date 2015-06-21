require 'spec_helper'
describe Naminori::Service do
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
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:notifier).twice
        options = { notifier: Naminori::Notifier.get_notifier("slack") }
        Naminori::Service.event("dns", "lvs", options)
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:add_member).once
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
        Naminori::Service.event("dns", "lvs")
      end
    end

    describe 'member-leave' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
        allow(Naminori::Serf).to receive(:leave?).and_return(true)
        allow(STDIN).to receive(:gets).and_return(SerfStub.event)
      end
      it do
        expect(Naminori::Lb::Lvs).to receive(:notifier).twice
        options = { notifier: Naminori::Notifier.get_notifier("slack")}
        Naminori::Service.event("dns", "lvs", options)
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:add_member).never
        expect(Naminori::Lb::Lvs).to receive(:delete_member).once
        Naminori::Service.event("dns", "lvs")
      end
    end
  end
end
