require 'test_helper'

# TODO: Think of a way to test Impersonation when enable_impersonation on and off
module Martinet
  describe Impersonation do
    subject { Session.new(warden) }

    describe '#impersonate!' do
      it 'moves impersonator to :impersonator scope and adds new user to :default scope' do
        subject.sign_in!('I am an admin')

        subject.impersonate!('I am a user')

        assert_signed_in(user: 'I am a user')
        assert_signed_in(user: 'I am an admin', scope: :impersonator)
      end

      it 'finds impersonator from given scope' do
        subject.sign_in!('I am an admin', scope: :admin)

        subject.impersonate!('I am a user', impersonator_scope: :admin)

        assert_signed_in(user: 'I am a user')
        assert_signed_in(user: 'I am an admin', scope: :impersonator)
        assert_signed_in(user: 'I am an admin', scope: :admin)
      end
    end

    describe '#impersonating?' do
      it 'returns true if impersonating' do
        subject.sign_in!('I am an admin')
        subject.impersonate!('I am a user')

        subject.impersonating?.must_equal true
      end

      it 'returns false if unmasked' do
        subject.sign_in!('I am an admin')
        subject.impersonate!('I am a user')
        subject.unmask!

        subject.impersonating?.must_equal false
      end

      it 'returns false if impersonation not started' do
        subject.impersonating?.must_equal false
      end
    end

    describe '#unmask!' do
      it 'moves impersonator to :default scope' do
        subject.sign_in!('I am an admin')
        subject.impersonate!('I am a user')

        subject.unmask!

        assert_signed_in(user: 'I am an admin')
        assert_signed_out(scope: :impersonator)
      end

      it 'signs out all scopeand and moves impersonator to :default scope' do
        subject.sign_in!('I am an admin', scope: :admin)
        subject.impersonate!('I am a user', impersonator_scope: :admin)

        subject.unmask!

        assert_signed_in(user: 'I am an admin')
        assert_signed_out(scope: :impersonator)
        assert_signed_out(scope: :admin)
      end
    end
  end
end
