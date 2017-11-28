require "active_record"
require "with_lock_version/version"
require "with_lock_version/active_record_ext"

module WithLockVersion
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.include(WithLockVersion::ActiveRecordExt)
end
