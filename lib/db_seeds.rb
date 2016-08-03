require 'bundler'
Bundler.require

credentials = {
  adapter:   'mysql2',
  encoding:  'utf8',
  collation: 'utf8_general_ci',
  host:      ENV['HOST'] || 'localhost',
  port:      ENV['PORT'] || 3306,
  database:  ENV['DB'],
  username:  ENV['USER'],
  password:  ENV['PASS']
}

ActiveRecord::Base.establish_connection(credentials)

class Address < ActiveRecord::Base; end

def do_seed
  fax = '0120-000-000'
  values = []

  100_000.times.each do |idx|
    values << ["#{fax.succ!}"]
    bulk_insert!(values) if ((idx + 1) % 10_000).zero?
  end
end

def bulk_insert!(values)
  Address.import(%i(fax), values, validate: false, timestamps: false)
  values.clear
end

puts 'Start db:seed'
do_seed
puts 'Finish db:seed'
