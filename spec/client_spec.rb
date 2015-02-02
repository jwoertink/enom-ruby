require_relative 'spec_helper'

RSpec.describe EnomRuby::Client do

  describe '.base_uri' do

    it 'returns the enom test domain when set to test' do
      expect(EnomRuby::Client.base_uri).to eq "https://resellertest.enom.com/interface.asp"
    end

    context 'when in production mode' do
      before { EnomRuby::Client.test_mode = false }
      after { EnomRuby::Client.test_mode = true }

      it 'returns the enom production domain when test it set to false' do
        expect(EnomRuby::Client.base_uri).to eq "https://reseller.enom.com/interface.asp"
      end
    end
  end

end
