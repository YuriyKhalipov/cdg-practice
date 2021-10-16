FILE_PATH = 'students.txt'
RESULTS = 'results.txt'

def where(pattern, file_path) # находит все строки, где есть указанный паттерн
  indexes = []
  File.foreach(file_path).with_index do |line, index|
    if line.match(/\b#{pattern}\b/)
      @line_id = index 
      indexes.push(@line_id)
    end
  end
  indexes
end

def index(file_path) # выводит все строки
  File.foreach(file_path){ |line| puts line }
end

def file_to_array(arr, file_path)
  File.foreach(file_path){ |line| arr.push(line) }
  arr
end

def write(file_data, indexes, file_path) # запись новых строк в файл
  indexes.each do |x|
    if where(file_data[x].chomp, file_path).empty?
      File.write(file_path, file_data[x], mode: "a")
      puts "Запись №#{x} '#{file_data[x].chomp}' добавлена в файл #{file_path}"
    end
  end
end

students = []
students = file_to_array(students, FILE_PATH)
File.write(RESULTS, "")
puts "Содержимое файла #{FILE_PATH}:"
puts students

loop do
  if students.length == File.read(RESULTS).each_line.count
    puts "========================================="
    puts "Все записи из файла #{FILE_PATH} добавлены в файл #{RESULTS}"
    puts "Содержимое файла #{RESULTS}:"
    index(RESULTS)
    break
  end
  puts "========================================="
  print "Введите возраст (-1 для выхода): "
  age = gets.chomp
  if age == "-1"
    puts "Содержимое файла #{RESULTS}:"
    index(RESULTS)
    break
  end
  write(students, where(age, FILE_PATH), RESULTS)
end


