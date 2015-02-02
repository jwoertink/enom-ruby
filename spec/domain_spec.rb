require_relative 'spec_helper'

RSpec.describe EnomRuby::Domain do

  describe '.check', vcr: true, focus: true do

    context 'with a valid SLD "google" and no extra TLDs' do
      it 'returns an array with a single domain object showing unavailable' do
        domain = EnomRuby::Domain.check('google').first
        expect(domain).to be_a(Domain)
        expect(domain).to be_unavailable
      end
    end
  end

end
