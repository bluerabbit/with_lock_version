ActiveRecord::Base.establish_connection(
  YAML.load(File.read("spec/database.yml"))["test"],
)

ActiveRecord::Schema.define version: 0 do
  create_table :orders, force: true do |t|
    t.integer :status, null: false
    t.integer :lock_version, default: 0, null: false
    t.timestamps
  end
end

class Order < ActiveRecord::Base
  with_lock_versionable
end
