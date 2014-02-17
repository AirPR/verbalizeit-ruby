module VerbalizeIt
  class Client
    include HTTParty
    include Text

    attr_accessor *Configuration::VALID_OPTIONS

    def initialize(options={})
      merged_options = VerbalizeIt.options.merge(options)

      Configuration::VALID_OPTIONS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def languages
      get("/v1/languages.json")
    end

    private

    def get(path, options = {})
      opts = { query: options.merge(auth_token: api_key) }
      self.class.get("#{api_url}#{path}", opts).parsed_response
    end

    def post(path, options = {})
      opts = { body: options.merge(auth_token: api_key) }
      self.class.post("#{api_url}#{path}", opts).parsed_response
    end
  end
end
