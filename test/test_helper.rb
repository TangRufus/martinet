# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'martinet'
require 'minitest/autorun'
require 'minitest/reporters'
require 'warden'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

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
