# WithLockVersion

[![Build Status](https://travis-ci.org/bluerabbit/with_lock_version.svg?branch=master)](https://travis-ci.org/bluerabbit/with_lock_version)

ActiveRecordでlock_versionカラムを使った楽観的ロックをする際に楽になるhelper methodを提供するgemです。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'with_lock_version'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install with_lock_version

## Usage

```ruby
  create_table :orders do |t|
    t.integer :lock_version, default: 0, null: false
    t.timestamps
  end
```

```ruby
class Order < ActiveRecord::Base
  with_lock_versionable # required lock_version and timestamp columns 
end
```


```ruby
order = Order.find(id)
order.with_lock_version(params[:lock_version]) do
  # something
end
```

lock_versionが一致しない場合はActiveRecord::StaleObjectErrorをraiseします。

## Development

```
%cp spec/database.yml.sample spec/database.yml
```

```
%bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bluerabbit/with_lock_version.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
