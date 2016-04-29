# frozen_string_literal: true

module Martinet
  # HTTP/Warden session-specific behavior.
  class Session
    def initialize(warden)
      @warden = warden
    end

    def current_user(scope: nil)
      @warden.user(scope)
    end

    def signed_in?(scope: nil)
      @warden.authenticated?(scope)
    end

    def sign_in!(user, *args)
      @warden.set_user(user, *args)
    end

    def sign_out!(scope: nil)
      if scope
        @warden.logout(scope)
      else
        @warden.logout
      end
    end
  end
end
