module WithLockVersion
  module ActiveRecordExt
    def self.included(model)
      model.extend ClassMethods
    end

    module ClassMethods
      def with_lock_versionable
        include WithLockVersion::ActiveRecordExt::Core
      end
    end

    module Core
      def self.included(model)
        model.extend ClassMethods
      end

      def with_lock_version(target_lock_version)
        unless lock_version.to_i == target_lock_version.to_i
          raise ActiveRecord::StaleObjectError
        end

        with_lock do
          unless lock_version.to_i == target_lock_version.to_i
            raise ActiveRecord::StaleObjectError
          end

          touch # Update lock_version + 1

          yield
        end
      end
    end
  end
end
