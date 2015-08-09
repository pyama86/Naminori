require 'spec_helper'
describe Naminori::Configure do
  describe 'set_value_check' do
    describe "ok" do
      before do
        Naminori.configure do |config|
          config.notifier :slack do
            webhook_url "http://hoge.com"
            user        "hoge"
            channel     "fuga"
          end
        end
      end
      
      it do
        expect(Naminori.configure.notifier.first.slack_enable?).to be_truthy
        expect(Naminori.configure.notifier.first.webhook_url).to eq "http://hoge.com"
        expect(Naminori.configure.notifier.first.user).to eq "hoge"
        expect(Naminori.configure.notifier.first.channel).to eq "fuga"
      end
    end
  end
end
