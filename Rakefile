require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH << __dir__

require 'active_support/all'
require_all './lib'

unless ENV['APP_MODE'] == 'production'
  require 'pry'
end

task :run do
  input_file_path = ENV['INPUT_FILE_PATH'] || './lib/input/yesware-test-data-v1.txt'
  output_file_path = ENV['OUTPUT_FILE_PATH'] || './lib/output/yesware-output.txt'

  unique_names_list_length = ENV['UNIQUE_NAMES_LIST_LENGTH'] || 25
  GenerateOutputFile.new.execute(input_file_path, output_file_path, unique_names_list_length)
end
