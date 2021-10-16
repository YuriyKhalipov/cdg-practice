FILE_PATH = 'test.txt'
BUFFER = 'buffer.txt'

def index # выводит все строки
  File.foreach(FILE_PATH){ |line| puts line }
end

def find(id) # находит конкретную строку в файле и выводит ее
  File.foreach(FILE_PATH).with_index do |line, index|
    if id == index
      puts line
    end
  end
end

def where(pattern) # находит все строки, где есть указанный паттерн
  indexes = []
  File.foreach(FILE_PATH).with_index do |line, index|
    if line.include?(pattern)
      @line_id = index 
      indexes.push(@line_id)
    end
  end
  indexes
end

def update(id, text) # обновляет конкретную строку файла
  file = File.open(BUFFER, 'w')
  File.foreach(FILE_PATH).with_index do |line, index|
    file.puts(id == index ? text : line)
  end

  file.close
  File.write(FILE_PATH, File.read(BUFFER))

  File.delete(BUFFER) if File.exist?(BUFFER)
end

def delete(id) # удаляет строку
  file = File.open(BUFFER, 'w')
  File.foreach(FILE_PATH).with_index do |line, index|	
    if id != index
      file.puts line
    end
  end

  file.close
  File.write(FILE_PATH, File.read(BUFFER))

  File.delete(BUFFER) if File.exist?(BUFFER)
end	

