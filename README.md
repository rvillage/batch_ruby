# batch_ruby

## setup
```sh
$ cd path/to
$ git clone git@github.com:rvillage/batch_ruby.git
$ cd batch_ruby
$ bundle install --path vendor/bundle
```

## run
```sh
$ cd path/to/batch_ruby
$ HOST=localhost PORT=3306 DB=__dbname__ USER=__user__ PASS=__pass__ bundle exec ruby ./lib/batch_sample.rb
```
