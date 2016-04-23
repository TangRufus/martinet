module Martinet
  module Impersonation
    def impersonate!(user, impersonator_scope: nil)
      impersonator = current_user(scope: impersonator_scope)
      sign_in!(impersonator, scope: :impersonator)
      sign_in!(user)
    end

    def impersonating?
      signed_in?(scope: :impersonator)
    end

    def unmask!
      impersonator = current_user(scope: :impersonator)
      sign_out!
      sign_in!(impersonator)
    end
  end
end
