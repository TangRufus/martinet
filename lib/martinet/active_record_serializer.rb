module Martinet
  class ActiveRecordSerializer
    def self.serialize(record:)
      return record unless serializable?(record: record)
      { klass: record.class.name, record_id: record.id }
    end

    def self.deserialize(object_hash:)
      record_for(object_hash: object_hash) || object_hash
    end

    def self.record_for(object_hash:)
      return unless deserializable?(object_hash: object_hash)

      record_klass = object_hash[:klass].safe_constantize
      record_klass.find_by(id: object_hash[:record_id])
    end

    # FIXME: Refactor this method
    def self.serializable?(record:)
      record.respond_to?(:id) && record.id.presence && record.class.respond_to?(:find_by)
    end

    # FIXME: Refactor this method, maybe a rescue block?
    def self.deserializable?(object_hash:)
      valid = [:klass, :record_id].all? do |k|
        object_hash.respond_to?(:key) && object_hash.key?(k) && object_hash[k].presence
      end
      valid && object_hash[:klass].safe_constantize.respond_to?(:find_by)
    end
  end
end
