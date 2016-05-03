# frozen_string_literal: true

require 'warden'

module Martinet
  module Test
    module Helpers
      include Warden::Test::Mock

      def setup
        request.env['warden'] = warden
      end

      def teardown
        Warden.test_reset!
      end
    end
  end
end
