# The NGP VAN Ruby Gem

[![Maintainability](https://api.codeclimate.com/v1/badges/7626459ccc64fda20e68/maintainability)](https://codeclimate.com/github/christopherstyles/ngp_van/maintainability) [![Inline docs](http://inch-ci.org/github/christopherstyles/ngp_van.svg?branch=master)](http://inch-ci.org/github/christopherstyles/ngp_van) [![Gem Version](https://badge.fury.io/rb/ngp_van.svg)](https://badge.fury.io/rb/ngp_van)

An unofficial Ruby wrapper for the [NGP VAN](http://developers.everyaction.com/) RESTful API.

## Quick start

Install via Rubygems:

```ruby
gem install ngp_van
```

Or add this line to your application's Gemfile:

```ruby
gem 'ngp_van'
```

### Security

`ngp_van` is cryptographically signed. To be sure the gem you install hasn’t been tampered with, add the public key as a trusted certificate:

    gem cert --add <(curl -Ls https://raw.github.com/christopherstyles/ngp_van/master/certs/christopherstyles.pem)

Then install with:

    gem install ngp_van -P MediumSecurity

or if using bundler:

    bundle install --trust-policy MediumSecurity

The `MediumSecurity` trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary because not all of `ngp_van`s dependencies are signed, so we cannot use `HighSecurity`.

## Configuration

NGP VAN can be configured using a block:

```ruby
NgpVan.configure do |config|
  config.application_name = 'MyCampaignApp'

  # See http://developers.everyaction.com/van-api#van-authentication
  config.api_key = 'de286a1a-f2e7-421a-91b8-f8cc8201558f|1'

  # Defaults to "https://api.securevan.com/v4/"
  config.api_endpoint = 'https://intlapi.securevan.com/v4'

  # Defaults to "NGP VAN Ruby Gem #{NgpVan::VERSION}"
  config.user_agent = 'CustomUserAgent'
end
```

Options can also be set on the configuration object:

```ruby
% NgpVan.configuration.api_key = 'de286a1a-f2e7-421a-91b8-f8cc8201558f|1'
# => "de286a1a-f2e7-421a-91b8-f8cc8201558f|1"
```

In a multi-threaded environment you may want to use multiple configurations simultaneously.
In that case, pass an appropriately setup configuration class to the client object.

```ruby
configuration = NgpVan::Configuration.new
configuration.api_key = 'de286a1a-f2e7-421a-91b8-f8cc8201558f|1'
client = NgpVan::Client.new(configuration)
client.district_fields

```

## Making requests

API Methods can be called as module methods or as instance methods on the client.

```ruby
NgpVan.district_fields
# => [
#      {"districtFieldId"=>1, "name"=>"State", "parentFieldId"=>nil...},
#      {"districtFieldId"=>4, "name"=>"County", "parentFieldId"=>1...}
#    ]
```

or

```ruby
client = NpgVan.client
client.district_fields
# => [
#      {"districtFieldId"=>1, "name"=>"State", "parentFieldId"=>nil...},
#      {"districtFieldId"=>4, "name"=>"County", "parentFieldId"=>1...}
#    ]
```

## Development

After checking out the repo, run `rake spec` to run the tests.

A console task has also been provided to automatically load the NGP VAN environment. Run `bin/console` for an interactive prompt that will allow you to experiment.

```ruby
% bin/console
[1] pry(main)> NgpVan::VERSION
# => "x.x.x"
[2] pry(main)> NgpVan.configuration.application_name = 'MyCampaignApplication'
# => "MyCampaignApplication"
[3] pry(main)> NgpVan.configuration.api_key = 'de286a1a-f2e7-421a-91b8-f8cc8201558f|1'
# => "de286a1a-f2e7-421a-91b8-f8cc8201558f|1"
[4] pry(main)> NgpVan.district_fields
# => [
#      {"districtFieldId"=>1, "name"=>"State", "parentFieldId"=>nil...,
#      {"districtFieldId"=>2, "name"=>"County", "parentFieldId"=>1...
#    ]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/christopherstyles/ngp_van/issues.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
