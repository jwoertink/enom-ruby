require 'hashie/mash'

module EnomRuby

  class Domain
    DEFAULT_TLDS = ['com']

    # Check a particular domain (sld) with an array of tlds (tld_list)
    def self.check(sld, tld_list = DEFAULT_TLDS)
      response = Client.request(command: 'Check', sld: sld, tldlist: Array(tld_list).join(','))
      domains = Hash[*Array(response['Domain']).zip(Array(response['RRPText'])).flatten]
      [].tap do |results|
        domains.each_pair { |domain, text| results << new(domain, text) }
      end
    end

    # Return an array of all the available TLDs to check against
    def self.tld_list
      response = Client.request(command: 'GetTLDList')
      tld_list = response['tldlist']['tld'].collect(&:values).flatten
      tld_list.compact.reject {|d| d.include?('--') || d.match(/\d+/) }
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
