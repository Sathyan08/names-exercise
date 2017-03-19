require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH << __dir__

require 'active_support/all'
require_all './lib'

unless ENV['APP_MODE'] == 'production'
  require 'pry'
end

task :run do
  input_file_path = './lib/input/yesware-test-data-v1.txt'
  output_file_path = './lib/output/yesware-output.txt'

  GenerateOutputFile.new.execute(input_file_path, output_file_path)
end
