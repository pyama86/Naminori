require 'spec_helper'
describe Naminori::Service do
  describe 'event' do
    before do
      allow(Naminori::Serf).to receive(:members).and_return(SerfStub.exists_member)
      allow_any_instance_of(Slack::Notifier).to receive(:ping).and_return(true)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
      Naminori::Notifier.configure do
        webhook_url "https://hooks.slack.com/services/XXXXXX"
        channel     "#pyama"
        user        "#naminori"
      end
    end

    describe 'member-join' do
      shared_examples_for 'member-join' do
        before do
          allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
          allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
          allow_any_instance_of(Naminori::Service::Http).to receive(:healty?).and_return(true)
          allow(Naminori::Serf).to receive(:join?).and_return(true)
          allow(STDIN).to receive(:gets).and_return(SerfStub.event)
        end

        it do
          expect(Naminori::Lb::Lvs).to receive(:notifier).exactly(notifer_count).times
          Naminori::Service.event(service, "lvs")
        end

        it do
          expect(Naminori::Lb::Lvs).to receive(:add_member).once
          expect(Naminori::Lb::Lvs).to receive(:delete_member).never
          Naminori::Service.event(service, "lvs")
        end
      end

      describe 'dns' do
        let(:service) { "dns" }
        let(:notifer_count) { 2 }
        it_behaves_like 'member-join'
      end

      describe 'http' do
        let(:service) { "http" }
        let(:notifer_count) { 1 }
        it_behaves_like 'member-join'
      end

    end
    describe 'member-leave' do
      shared_examples_for 'member-leave' do
        before do
          allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
          allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
          allow(Naminori::Serf).to receive(:leave?).and_return(true)
          allow(STDIN).to receive(:gets).and_return(SerfStub.event)
        end
        it do
          expect(Naminori::Lb::Lvs).to receive(:notifier).exactly(notifer_count).times
          Naminori::Service.event(service, "lvs")
        end

        it do
          expect(Naminori::Lb::Lvs).to receive(:add_member).never
          expect(Naminori::Lb::Lvs).to receive(:delete_member).once
          Naminori::Service.event(service, "lvs")
        end
      end

      describe 'dns' do
        let(:service) { "dns" }
        let(:notifer_count) { 2 }
        it_behaves_like 'member-leave'
      end

      describe 'http' do
        let(:service) { "http" }
        let(:notifer_count) { 1 }
        it_behaves_like 'member-leave'
      end
    end
  end
end
