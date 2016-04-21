require 'test_helper'
require 'active_record_test_helper'
require 'martinet/active_record_serializer'

module Martinet
  class ActiveRecordSerializerTest < MiniTest::Spec
    describe 'Martinet::ActiveRecordSerializer' do
      let(:richard) { User.create!(name: 'Richard Roe') }
      let(:john) { User.create!(name: 'John Doe') }
      let(:mark) { User.create!(name: 'Mark Moe') }
      let(:unborn) { User.new(name: 'Unborn Baby') }
      let(:not_an_active_record) { Hash[id: 666, name: 'I am a hash'] }

      describe 'serialize' do
        it 'serializes model to hash' do
          result = ActiveRecordSerializer.serialize(record: john)

          result.must_be_instance_of Hash
          result[:klass].must_equal 'User'
          result[:record_id].must_equal john.id
        end

        it 'passes through original object if record not persisted' do
          result = ActiveRecordSerializer.serialize(record: unborn)

          result.must_equal unborn
        end

        it 'passes through non ActiveRecord objects' do
          result = ActiveRecordSerializer.serialize(record: not_an_active_record)

          result.must_equal not_an_active_record
        end
      end

      describe '#deserialize' do
        it 'deserializes model from hash' do
          result = ActiveRecordSerializer.deserialize(object_hash: { klass: 'User', record_id: john.id })

          result.must_equal john
        end

        it 'returns original object if record not found' do
          object_hash = { klass: 'User', record_id: mark.id }
          mark.destroy!

          result = ActiveRecordSerializer.deserialize(object_hash: object_hash)

          result.must_equal object_hash
        end

        it 'passes through non ActiveRecord objects' do
          result = ActiveRecordSerializer.deserialize(object_hash: not_an_active_record)

          result.must_equal not_an_active_record
        end

        it 'passes through objects without klass and id' do
          result = ActiveRecordSerializer.deserialize(object_hash: 'I am a string')

          result.must_equal 'I am a string'
        end
      end
    end
  end
end
