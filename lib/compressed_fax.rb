require 'bundler'
Bundler.require

load 'lib/compressable.rb'

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
ActiveRecord::Base.logger = Logger.new('log/sql.log')
logger = Logger.new('log/batch.log')

class Address < ActiveRecord::Base; end


def compressed!(logger)
  Address.all.each do |addr|
    addr.update_attributes!(compress_fax: Compressible.compress_number(addr.fax))
  end
end


begin
  started_at = Time.now
  puts 'Start compressed_fax'

  compressed!(logger)
ensure
  puts "Finish #{"%.3f" % ((Time.now - started_at) * 1_000)}ms compressed_fax"
end
