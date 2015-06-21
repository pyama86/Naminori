require 'spec_helper'
describe Naminori::Lb do
  describe 'helth_check' do
    before do
      allow(Naminori::Serf).to receive(:members).and_return(SerfStub.exists_member)
      allow_any_instance_of(Kernel).to receive(:system).and_return(true)
    end

    describe 'good health' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.unregistered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:add_member).once
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
        Naminori::Lb.health_check("dns", "lvs")
      end
    end

    describe 'keep good health' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(true)
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:delete_member).never
        Naminori::Lb.health_check("dns", "lvs")
      end
    end

    describe 'bad health' do
      before do
        allow(Naminori::Lb::Lvs).to receive(:fetch_service).and_return(LbStub.registered_rip)
        allow_any_instance_of(Naminori::Service::Dns).to receive(:healty?).and_return(false)
      end

      it do
        expect(Naminori::Lb::Lvs).to receive(:add_member).never
        expect(Naminori::Lb::Lvs).to receive(:delete_member).once
        Naminori::Lb.health_check("dns", "lvs")
      end
    end
  end
end
