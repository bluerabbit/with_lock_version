require "spec_helper"

describe WithLockVersion do
  it "has a version number" do
    expect(WithLockVersion::VERSION).not_to be nil
  end

  describe "#with_lock_version" do
    it "correct lock_version" do
      order = Order.create(status: 1)

      expect(order.lock_version).to eq(0)

      order.with_lock_version(0) do # lock_version + 1
        # void
      end

      expect(order.lock_version).to eq(1)

      order.with_lock_version(1) do         # lock_version + 1
        order.update!(status: 2) # lock_version + 1
      end

      expect(order.lock_version).to eq(3)
      expect(order.status).to eq(2)
    end

    it "incorrect lock_version" do
      order = Order.create(status: 1, lock_version: 0)

      expect {
        order.with_lock_version(1) do
          order.update!(status: 2)
        end
      }.to raise_error(ActiveRecord::StaleObjectError)

      expect(order.lock_version).to eq(0)
      expect(order.status).to eq(1)
    end
  end
end
