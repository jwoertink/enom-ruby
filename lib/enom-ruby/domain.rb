module EnomRuby

  class Domain
    DEFAULT_TLDS = ['com']

    def self.check(sld, tld_list = DEFAULT_TLDS)
      Client.request(command: 'Check', sld: sld, tldlist: tld_list.join(','))
    end
  end
end
