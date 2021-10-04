[![Main workflow](https://github.com/otmosina/rails-project-lvl1/actions/workflows/main.yml/badge.svg)](https://github.com/otmosina/rails-project-lvl1/actions/workflows/main.yml)
[![hexlet-check](https://github.com/otmosina/rails-project-lvl1/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/otmosina/rails-project-lvl1/actions/workflows/hexlet-check.yml)

# HexletCode

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hexlet_code`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code
    
For local development you must have ruby >= 3.0.1 and just run

    $ make up

## Usage

### HexletCode::Tag.build

Use **HexletCode::Tag.build** for write html tags

`HexletCode::Tag.build('br')` => `<br>`

`HexletCode::Tag.build('img', src: 'path/to/image'))` => `<img src="path/to/image">`

`HexletCode::Tag.build('input', type: 'submit', value: 'Save')` => `<input type="submit" value="Save">`

Pass block as argument to put anything inside tag

`HexletCode::Tag.build('label') { 'Email' })` => `<label>Email</label>`

`HexletCode::Tag.build('label', for: 'email') { 'Email' })` => `<label for="email">Email</label>`

### HexletCode.form_for

Use HexletCode.form_for to write html form. Pass object as parameter and block which will be rendered as forms fields

```
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
  f.input :gender, as: :select, collection: %w[m f]
end
```

=>
```
<form action="#" method="post">
  <label for="name">Name</label>
  <input type="text" name="name" value="rob">
  <label for="job">Job</label>
  <textarea name="job" cols="20" rows="40">hexlet</textarea>
  <label for="gender">Gender</label>
  <select name="gender">
  <option value="m" selected>m</option>
  <option value="f">f</option>
  </select>
</form>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code.
