require 'premailer'
require 'colorize'
require_relative 'hash'

class PremailClass
  def initialize
    folder = ARGV[0].downcase.to_sym
    infile = ARGV[1].downcase << ".html"

    if FOLDER_LIST.has_key?(folder)
      Dir.chdir(FOLDER_LIST[folder])
    else
      puts "That folder doesn't exist".red
      abort
    end #end if statement

    if File.exist?(infile)
      #do stuff if the file does exist
      @input_file = File.path(infile)
      outfile = File.basename(@input_file, ".*")
      @output_file = File.path("#{outfile}-premailer.html")
    else
      puts "That file does not seem to exist".red
      abort
    end #end if statement
  end #end initialize method

  def reset_log
    base_name = File.basename(@input_file, ".*")
    @log_file = File.path("#{base_name}-log.txt")
    File.open(@log_file, "w") do |x|
      time = Time.new
      x.puts time.inspect
      x.puts "\n"
    end #end file open
  end #end reset_log method

  def premail_it
    @premailer = Premailer.new(@input_file, warn_level: Premailer::Warnings::SAFE, remove_classes: true, remove_ids: true, adapter: :nokogiri, preserve_styles: false)

    #write HTML output
    File.open(@output_file, "w") do |x|
      x.puts @premailer.to_inline_css
    end

    #write plain text-output
    #File.open("#{output_file}.txt", "w") do |x|
    #  x.puts @premailer.to_plain_text
    #end
  end #end premail_it method

  def output
    #output CSS warnings
    @premailer.warnings.each do |x|
      puts "#{x[:message]} (#{x[:level]}) may not  render properly in #{x[:clients]}".colorize(:red)

      # writing log file
      File.open(@log_file, "a") do |y|
        y.puts "#{x[:message]} (#{x[:level]}) may not render properly in #{x[:clients]}"
      end
    end

    puts "The operation ran successfully".green
    puts "The input file was #{@input_file}".green
    puts "The output file was #{@output_file}".green
    puts "The log file was #{@log_file}".green
  end #end output method
end #end class
