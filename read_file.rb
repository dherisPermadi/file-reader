class ReadFile
  # default array of contents
  def self.data_clear
    @contents = []
  end

  def self.read_folder(directory)
    @files = Dir.glob("#{directory}*.*")

    self.read_files
  end

  def self.read_files
    if @files != []
      @files.each { |file| self.read(file) }
      max_data = @contents.max_by{|k,v| v}
      puts "#{max_data[:description]} #{max_data[:total]}"
    else
      puts 'No File exist!'
    end
  end

  def self.read(file)
    file             = File.open(file)
    description      = file.read[0...50] # limit content only get 50 characters
    existing_content = @contents.select { |hash| hash[:description] == description }

    if existing_content != []
      existing_content[0][:total] += 1
    else
      @contents << { description: description, total: 1 }
    end
  end
end

ReadFile.data_clear
puts "Please input the directory path: (example: 'name-folder/' or 'name-folder/name-sub-folder/')"
directory = gets.chomp
ReadFile.read_folder(directory)