require 'test_helper'

describe Martinet::Configuration do
  describe '#enable_impersonation' do
    subject { Martinet.configuration.enable_impersonation }

    # FIXME: enable_impersonation is default becuase of easier testing
    it 'defaults enabled' do
      subject.must_equal true
    end

    it 'can be enabled' do
      Martinet.configure do |config|
        config.enable_impersonation = true
      end

      subject.must_equal true
    end

    it 'can be disabled' do
      Martinet.configure do |config|
        config.enable_impersonation = false
      end

      subject.must_equal false
    end
  end
end
