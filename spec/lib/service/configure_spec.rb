require 'spec_helper'
describe Naminori::Service::Configure do
  describe 'set_value_check' do
    describe "ok" do
      before do
        Naminori.configure do |config|
          config.service :dns_server do
            service      :dns
            lb           :lvs
            port         '53'
            protocols    ['tcp']
            method       'gateway'
            query        'test'
            retry_num    '3'
            timeout      '5'
            vip          '192.168.77.9'
          end
        end
      end

      it do
        expect(Naminori.configure.service.first.role).to eq :dns_server
        expect(Naminori.configure.service.first.service).to eq :dns
        expect(Naminori.configure.service.first.lb).to eq :lvs
        expect(Naminori.configure.service.first.port).to eq '53'
        expect(Naminori.configure.service.first.protocols).to eq ['tcp']
        expect(Naminori.configure.service.first.method).to eq 'gateway'
        expect(Naminori.configure.service.first.query).to eq 'test'
        expect(Naminori.configure.service.first.retry_num).to eq '3'
        expect(Naminori.configure.service.first.timeout).to eq '5'
        expect(Naminori.configure.service.first.vip).to eq '192.168.77.9'
      end
    end
  end
end
