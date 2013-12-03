# Carrierwave::Tire

This gem provides [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) functionality in Classes persisted by [Tire](https://github.com/karmi/retire)

## Installation

Add this line to your application's Gemfile:

    gem 'carrierwave-tire', git: "git@github.com:megorei/carrierwave-tire.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-tire

## Usage

Include CarrierWave::Tire mounter into your model and mount your uploader on a property. For more information about how to write an uploader see [CarrierWave documentation](https://github.com/carrierwaveuploader/carrierwave).

```ruby
class Article
  include Tire::Model::Persistence
  include CarrierWave::Tire

  property :filename

  mount_uploader :image, ImageUploader, mount_on: :filename
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
