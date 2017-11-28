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
          raise_error
        end

        with_lock do
          unless lock_version.to_i == target_lock_version.to_i
            raise_error
          end

          touch # Update lock_version + 1

          yield
        end
      end

      private

      def raise_error
        if ActiveRecord::StaleObjectError.method(:new).arity == 0
          raise ActiveRecord::StaleObjectError
        else
          raise ActiveRecord::StaleObjectError.new(self, "with_lock_version mismatch")
        end
      end
    end
  end
end
