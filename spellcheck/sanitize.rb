require 'find'

path_to_corpus = '/home/pawandubey/repository/ruby_experiments/spellcheck/corpus'
path_to_sanitized_file = 'sanitized.txt'

File.delete(path_to_sanitized_file) if File.exist?(path_to_sanitized_file)

File.open(path_to_sanitized_file, 'w') do |file|
  files_read = 0
  Find.find(path_to_corpus) do |path|
    begin
      next if FileTest.directory?(path) || File.basename(path)[0] == '.'
      text = File.read(path)
      file.puts text.gsub(/[^A-Za-z0-9\n ]/, '').gsub(/[\s|\n]+/, ' ').downcase
      files_read += 1
    rescue => e
      puts "Total #{files_read} files read. Error reading #{path}"
      puts e.message
    end
  end
  puts "Total #{files_read} files read."
end
