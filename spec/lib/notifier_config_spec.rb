require 'spec_helper'
describe Naminori::Notifier do
  describe 'set_value_check' do
    before do
      Naminori::Notifier::Configure.clear
    end

    describe "ok" do
      before do
        Naminori::Notifier.configure do
          webhook_url "http://hoge.com"
          user        "hoge"
          channel     "fuga"
        end
      end

      it do
        expect(Naminori::Notifier::Configure.slack_enable?).to be_truthy
        expect(Naminori::Notifier::Configure.webhook_url).to eq "http://hoge.com"
        expect(Naminori::Notifier::Configure.user).to eq "hoge"
        expect(Naminori::Notifier::Configure.channel).to eq "fuga"
      end
    end

    describe "ng" do
      before do
        Naminori::Notifier.configure do
          user        "hoge"
          channel     "fuga"
        end
      end
      
      it do
        expect(Naminori::Notifier::Configure.slack_enable?).to be_falsey 
      end
    end
  end
end
