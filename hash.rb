require 'colorize'

FOLDER_LIST = {
  test: "_TESTFILES",
  #add more here
}

FOLDER_LIST.each do |key, value|
  puts "key: #{key.to_s}".green + " "  + "value: #{value}".blue
end
