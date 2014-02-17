require 'spec_helper'

describe 'text api' do

  before do
    VerbalizeIt.configure do |config|
      config.api_key = VerbalizeIt::Configuration::DEFAULT_API_KEY
      config.api_url = VerbalizeIt::Configuration::DEFAULT_API_URL
    end
  end

  before do
    VCR.insert_cassette 'text api', :record => :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  let(:api) { VerbalizeIt::Client.new }

  it "gets request id when requesting a text translation" do
    response = api.basic_text("es", "Hello", "http://example.com/translate")
    response["id"].should_not be_nil
  end

  describe '.status' do

    it "gets the id from the status of a request" do
      response = api.status(424)
      response["id"].should == 424
    end

    it "gets the current status of a request" do
      response = api.status(424)
      response["status"].should == "open"
    end

  end
end
