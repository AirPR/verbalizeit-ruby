module VerbalizeIt
  module Configuration
    VALID_OPTIONS = [ :api_key, :api_url ]
    DEFAULT_API_KEY = "12345"
    DEFAULT_API_URL = "http://sandboxapi.verbalizeit.com"

    attr_accessor *VALID_OPTIONS

    def self.extended(base)
      base.reset
    end

    def reset
      self.api_key = DEFAULT_API_KEY
      self.api_url = DEFAULT_API_URL
    end

    def configure
      yield self
    end

    def options
      Hash[ * VALID_OPTIONS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
