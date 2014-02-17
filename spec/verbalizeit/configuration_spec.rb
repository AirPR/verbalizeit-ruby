require 'spec_helper'

describe "configuration" do

  VerbalizeIt::Configuration::VALID_OPTIONS.each do |key|
    describe ".#{key}" do
      it 'returns the default value' do
        VerbalizeIt.send(key).should ==
          VerbalizeIt::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end

  describe ".configure" do

    VerbalizeIt::Configuration::VALID_OPTIONS.each do |key|
      it "sets #{key}" do
        VerbalizeIt.configure do |config|
          config.send("#{key}=", key)
          VerbalizeIt.send(key).should == key
        end
      end
    end

  end
end
