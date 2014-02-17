module VerbalizeIt
  module Configuration
    VALID_OPTIONS = [ :api_key ]
    DEFAULT_API_KEY = nil

    attr_accessor *VALID_OPTIONS

    def self.extended(base)
      base.reset
    end

    def reset
      self.api_key = DEFAULT_API_KEY
    end

    def configure
      yield self
    end

    def options
      Hash[ * VALID_OPTIONS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
