$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'martinet'
require 'minitest/autorun'
require 'warden'

module MiniTest
  class Spec
    include Warden::Test::Mock

    after do
      Warden.test_reset!

      Martinet.configuration = nil
      Martinet.configure {}
    end

    protected

    def assert_signed_in(user:, scope: nil)
      subject.current_user(scope: scope).must_equal user
      subject.signed_in?(scope: scope).must_equal true
    end

    def assert_signed_out(scope: nil)
      subject.current_user(scope: scope).must_be_nil
      subject.signed_in?(scope: scope).must_equal false
    end
  end
end
