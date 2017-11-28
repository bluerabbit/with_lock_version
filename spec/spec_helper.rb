$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "with_lock_version"

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run

      raise ActiveRecord::Rollback
    end
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
