require 'test_helper'

class MartinetTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Martinet::VERSION
  end
end
