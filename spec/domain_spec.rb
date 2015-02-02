require_relative 'spec_helper'

RSpec.describe EnomRuby::Domain do

  describe '.check', vcr: true do

    context 'with a valid SLD "google" and no extra TLDs' do
      it 'returns an array with a single domain object showing unavailable' do
        domain = EnomRuby::Domain.check('google').first
        expect(domain).to be_a(EnomRuby::Domain)
        expect(domain).to be_unavailable
        expect(domain.url).to eq 'google.com'
      end
    end
  end

  describe '.tld_list', vcr: true, focus: true do
    subject { EnomRuby::Domain.tld_list }

    it 'returns an array including normal tld "com" and fancy tld "ninja"' do
      expect(subject).to include 'com'
      expect(subject).to include 'ninja'
    end

    it 'returns an array excluding foreign tlds like xn--mgbh0fb or 5earlyaccess' do
      test_results = subject.collect {|d| d.include?('--') || d.match(/\d+/)}.compact
      expect(test_results).to be_empty
    end
  end

end
