require 'spec_helper'
describe Naminori::Notifier::Configure do
  describe 'set_value_check' do
    describe "ok" do
      before do
        Naminori.configure do |config|
          config.lb :lb_role do
           check [:test_role] 
          end
        end
      end

      it do
        expect(Naminori.configure.lb.first.role).to eq :lb_role
        expect(Naminori.configure.lb.first.check).to eq [:test_role]
      end
    end
  end
end
