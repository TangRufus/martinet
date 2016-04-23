require 'test_helper'

module Martinet
  class SessionTest < MiniTest::Spec
    subject { Session.new(warden) }

    it 'nobody signs in before sign_in! is called' do
      subject.current_user.must_equal nil
      subject.signed_in?.must_equal false
      assert_signed_out(scope: :admin)
    end

    it 'signs in' do
      subject.sign_in!(Object)

      subject.current_user.must_equal Object
      subject.signed_in?.must_equal true
    end

    it 'signs out' do
      subject.sign_in!(Object)
      subject.sign_out!

      subject.current_user.must_equal nil
      subject.signed_in?.must_equal false
    end

    it 'signs in with scope' do
      subject.sign_in!(Object, scope: :admin)

      assert_signed_in(user: Object, scope: :admin)
    end

    it 'signs in with :default scope behaves like no scope' do
      subject.sign_in!(Object, scope: :default)

      assert_signed_in(user: Object)
    end

    it 'signs out with :default scope behaves like no scope' do
      subject.sign_in!(Object, scope: :default)
      subject.sign_out!(scope: :default)

      assert_signed_out
    end

    it 'signs out with scope' do
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

    it 'signs out with one scope' do
      subject.sign_in!(Object)
      subject.sign_in!('I am an admin', scope: :admin)

      subject.sign_out!(scope: :admin)

      assert_signed_in(user: Object)
      assert_signed_out(scope: :admin)
    end

    it 'signs out with default scope' do
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

    describe Impersonation do
      it 'included in Martinet::Session when impersonation enabled' do
        # TODO: Test if Martinet::Impersonation is inclued
        Martinet.configure do |config|
          config.enable_impersonation = true
        end

        subject.respond_to?(:impersonate!).must_equal true
      end

      it 'does not included in Martinet::Session when impersonation disabled' do
        # TODO: Test if Martinet::Impersonation is not inclued
        Martinet.configure do |config|
          config.enable_impersonation = false
        end

        subject.respond_to?(:impersonate!).must_equal false
      end
    end
  end
end
