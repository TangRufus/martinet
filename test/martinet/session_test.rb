require 'test_helper'

module Martinet
  class SessionTest < MiniTest::Spec
    subject { Session.new(warden) }

    it 'nobody signs in before sign_in! is called' do
      subject.current_user.must_equal nil
      subject.signed_in?.must_equal false
      assert_signed_out(scope: :admin)
    end

    it 'signs object in' do
      subject.sign_in!(Object)

      subject.current_user.must_equal Object
      subject.signed_in?.must_equal true
    end

    it 'signs object out' do
      subject.sign_in!(Object)
      subject.sign_out!

      subject.current_user.must_equal nil
      subject.signed_in?.must_equal false
    end

    it 'signs object in with scope' do
      subject.sign_in!(Object, scope: :admin)

      assert_signed_in(user: Object, scope: :admin)
    end

    it 'signs object out with scope' do
      subject.sign_in!(Object, scope: :admin)
      subject.sign_out!(scope: :admin)

      assert_signed_out(scope: :admin)
    end

    it 'signs in different objects in different scopes' do
      subject.sign_in!(Object)
      subject.sign_in!('I am an admin', scope: :admin)

      assert_signed_in(user: Object)
      assert_signed_in(user: 'I am an admin', scope: :admin)
    end

    it 'signs out object in one scope' do
      subject.sign_in!(Object)
      subject.sign_in!('I am an admin', scope: :admin)

      subject.sign_out!(scope: :admin)

      assert_signed_in(user: Object)
      assert_signed_out(scope: :admin)
    end

    it 'signs out object in default scope' do
      subject.sign_in!(Object)
      subject.sign_in!('I am an admin', scope: :admin)

      subject.sign_out!(scope: :default)

      assert_signed_out
      assert_signed_in(user: 'I am an admin', scope: :admin)
    end

    it 'signs out all objects in all scopes' do
      subject.sign_in!(Object)
      subject.sign_in!('I am an admin', scope: :admin)

      subject.sign_out!

      assert_signed_out
      assert_signed_out(scope: :admin)
    end

    private

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
