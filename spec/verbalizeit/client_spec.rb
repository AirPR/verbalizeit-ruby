require 'spec_helper'

describe VerbalizeIt::Client do

  before do
    @keys = VerbalizeIt::Configuration::VALID_OPTIONS
  end

  describe 'with module configuration' do
    before do
      VerbalizeIt.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      VerbalizeIt.reset
    end

    it "inherits module configuration" do
      api = VerbalizeIt::Client.new
      @keys.each do |key|
        api.send(key).should == key
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          :api_key    => 'apikey',
        }
      end

      it 'should override module configuration' do
        api = VerbalizeIt::Client.new(@config)
        @keys.each do |key|
          api.send(key).should == @config[key]
        end
      end

      it 'overrides module configuration after' do
        api = VerbalizeIt::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          api.send("#{key}").should == @config[key]
        end
      end

    end

  end

end
