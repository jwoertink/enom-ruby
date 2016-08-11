require 'hashie/mash'

module EnomRuby

  class Domain
    DEFAULT_TLDS = ['com']

    # Check a particular domain (sld) with an array of tlds (tld_list)
    def self.check(sld, tld_list = DEFAULT_TLDS)
      response = Client.request(command: 'Check', sld: sld, tldlist: Array(tld_list).take(15).join(','))
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

    def self.bulk_register(sld, tld_list = DEFAULT_TLDS)
      responses = []
      tld_list.each_slice(4) do |group|
        query = {}
        group.each_with_index do |tld, idx|
          query["tld#{idx+1}"] = tld
          query["sld#{idx+1}"] = sld
        end
        query[:command] = 'AddBulkDomains'
        query[:producttype] = 'register'
        query[:listcount] = group.size
        responses << Client.request(query)
      end
      responses
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
