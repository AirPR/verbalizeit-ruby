# Verbalizeit

A thin ruby wrapper around the [VerbalizeIt Api](http://www.verbalizeit.com/verbalizeit-for/developers).

*Note: right now, only the text api is covered here.*

## Installation

Add this line to your application's Gemfile:

    gem 'verbalizeit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install verbalizeit

## Usage

### Instantiate a client

    client = VerbalizeIt::Client.new(api_key: "xxx",
                                     api_url: "https://sandboxapi.verbalizeit.com")

### Get a list of supported languages

    client.languages

### Submit some text for translation

    client.basic_text("es", "Hello", "http://example.com/callback")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
