$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
require 'martinet'
require 'minitest/autorun'
require 'warden'

CodeClimate::TestReporter.start

module MiniTest
  class Spec
    include Warden::Test::Mock

    after do
      Warden.test_reset!
    end
  end
end
