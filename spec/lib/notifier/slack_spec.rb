require 'spec_helper'
describe Naminori::Service do
  describe 'event' do
    before do
      Naminori.configure do |config|
        config.notifier :slack do
          webhook_url "http://hoge.com"
          user        "hoge"
          channel     "fuga"
        end
      end
    end

    describe 'member-join' do
      before do
        Naminori::Notifier.notify("add", "test message")
      end

      it { allow_any_instance_of(Slack::Notifier).to receive(:ping).with("add", "test message", Naminori.configure.notifier.first) }
    end
  end
end
