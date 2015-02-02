require 'hashie/mash'

module EnomRuby

  class Domain
    DEFAULT_TLDS = ['com']

    def self.check(sld, tld_list = DEFAULT_TLDS)
      response = Client.request(command: 'Check', sld: sld, tldlist: tld_list.join(','))
      domains = Hash[*Array(response['Domain']).zip(Array(response['RRPText'])).flatten]
      [].tap do |results|
        domains.each_pair { |domain, text| results << new(domain, text) }
      end
    end

    def initialize(domain, availability_text)
      @domain = domain
      @availability_text = availability_text
    end

    def available?
      @availability_text == 'Domain available'
    end

    def unavailable?
      not available?
    end

    def url
      @domain
    end

  end
end
