require 'test_helper'

module Martinet
  class SessionTest < MiniTest::Spec
    it 'nobody sign in before sign_in! is called' do
      session = Session.new(warden)

      session.current_user.must_equal nil
      session.signed_in?.must_equal false
    end

    it 'signs object in' do
      session = Session.new(warden)
      session.sign_in!(Object)

      session.current_user.must_equal Object
      session.signed_in?.must_equal true
    end

    it 'signs object out' do
      session = Session.new(warden)
      session.sign_in!(Object)
      session.sign_out!

      session.current_user.must_equal nil
      session.signed_in?.must_equal false
    end

    it 'signs object in with scope' do
      session = Session.new(warden)

      assert_signed_out(session: session, scope: :admin)

      session.sign_in!(Object, scope: :admin)

      assert_signed_in(session: session, user: Object, scope: :admin)
    end

    it 'signs object out with scope' do
      session = Session.new(warden)
      session.sign_in!(Object, scope: :admin)

      assert_signed_in(session: session, user: Object, scope: :admin)

      session.sign_out!(scope: :admin)

      assert_signed_out(session: session, scope: :admin)
    end

    it 'sign in different objects in different scopes' do
      session = Session.new(warden)
      session.sign_in!(Object)
      session.sign_in!('I am an admin', scope: :admin)

      assert_signed_in(session: session, user: Object)
      assert_signed_in(session: session, user: 'I am an admin', scope: :admin)
    end

    it 'sign out object in one scope' do
      session = Session.new(warden)
      session.sign_in!(Object)
      session.sign_in!('I am an admin', scope: :admin)

      session.sign_out!(scope: :admin)

      assert_signed_in(session: session, user: Object)
      assert_signed_out(session: session, scope: :admin)
    end

    it 'sign out all objects in all scopes' do
      session = Session.new(warden)
      session.sign_in!(Object)
      session.sign_in!('I am an admin', scope: :admin)

      session.sign_out!

      assert_signed_out(session: session)
      assert_signed_out(session: session, scope: :admin)
    end

    private

    def assert_signed_in(session:, user:, scope: nil)
      session.current_user(scope: scope).must_equal user
      session.signed_in?(scope: scope).must_equal true
    end

    def assert_signed_out(session:, scope: nil)
      session.current_user(scope: scope).must_be_nil
      session.signed_in?(scope: scope).must_equal false
    end
  end
end
