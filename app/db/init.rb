require 'data_mapper'

if ENV['RACK_ENV'] == 'test'
  DataMapper.setup(:default, 'mysql://root:root@localhost/flippd_test')
else
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, 'mysql://root:root@localhost/flippd')
end

# Require all of the files under /app/models/
models_directories = ["/../models/", "/../models/trophies/"]
models_directories.each do |models_directory|
  model_files = Dir[File.dirname(__FILE__) + models_directory + "*.rb"]
  model_files.each { |f| require f }
end

DataMapper.finalize

if ENV['RACK_ENV'] == 'test'
  DataMapper.auto_migrate!
else
  DataMapper.auto_upgrade!
end
