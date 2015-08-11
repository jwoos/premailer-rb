require_relative 'premailerclass.rb'

if ARGV.empty?
  puts "You must pass the folder and file".red
elsif ARGV.length == 1
  puts "You must pass both arguments".red
else
  premail_this = PremailClass.new
  premail_this.reset_log
  premail_this.premail_it
  premail_this.output
end
