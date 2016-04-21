$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'martinet'
require 'minitest/autorun'
require 'coveralls'
require 'warden'

Coveralls.wear!

module MiniTest
  class Spec
    include Warden::Test::Mock

    after do
      Warden.test_reset!
    end
  end
end
