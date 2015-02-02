require 'hashie/mash'

module EnomRuby

  class Domain
    DEFAULT_TLDS = ['com']

    def self.check(sld, tld_list = DEFAULT_TLDS)
      @response = Client.request(command: 'Check', sld: sld, tldlist: tld_list.join(','))
      clean_hash = @response['interface_response'].inject({}) {|hsh, (k,v)| hsh[k.downcase] = v; hsh }
      clean_hash['results'] = Hash[*clean_hash['domain'].zip(clean_hash['rrptext'])]
      Hashie::Mash.new(clean_hash)
    end
  end
end
