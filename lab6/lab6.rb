require 'socket'
require './answer.rb'

atm = CashMachine.new(FILE_PATH)

server = TCPServer.new('localhost', 3000)

while (connection = server.accept)
  method = nil
  value = nil

  request = connection.gets
  puts request
  next if request.nil?

  full_path = request.split(' ')

  next unless full_path[0] == 'GET'

  connection.puts show_answer(atm, full_path, method, value, FILE_PATH)

  connection.close
end