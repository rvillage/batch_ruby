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

class Address < ActiveRecord::Base; end


def compressed!(logger)
  Address.all.each do |addr|
    if fax?(addr.fax)
      addr.update_attributes!(compress_fax: addr.fax.gsub('-', ''))
    else
      logger.error "Found id: #{addr.id}, fax: #{addr.fax}"
    end
  end
end

def fax?(fax_no)
  !(fax_no =~ /^([\d|-]+)$/).nil?
end

logger.info 'Start compressed!'
compressed!(logger)
logger.info 'End compressed!'
