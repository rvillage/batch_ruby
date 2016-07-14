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
ActiveRecord::Base.logger = Logger.new('log/sql.log')
logger = Logger.new('log/batch.log')

class User < ActiveRecord::Base; end


logger.info User.first
