module VerbalizeIt
  class Client
    attr_accessor *Configuration::VALID_OPTIONS

    def initialize(options={})
      merged_options = VerbalizeIt.options.merge(options)

      Configuration::VALID_OPTIONS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end
  end
end
