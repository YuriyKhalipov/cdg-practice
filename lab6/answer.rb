require './atm.rb'

def show_answer(atm1, full_path1, method1, value1, file_path)
	path = full_path1[1].split('/')[1]
  
  if !path.nil? && path.include?('?')
    method1 = path.split('?')[0]
    value1 = path.split('?')[1].split('=')[1]
    value1 = 0.to_s if value1.nil? 
  elsif !path.nil? && !path.include?('?')
    method1 = path.split('?')[0]
    value1 = 0.to_s    
  elsif !path.nil?
    method1 = path
  end

  answer = "HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<title>#{method1}</title>"

  answer += case method1
            when 'deposit'
              atm1.deposit(value1,file_path).to_s
            when 'withdraw'
              atm1.withdraw(value1, file_path).to_s
            when 'balance'
              atm1.show_balance.to_s 
            when 'quit'
              exit
            else
              "Not found"
            end
end