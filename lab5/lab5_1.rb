class CashMachine
  def initialize
  	check_if_file_exists()
    menu(@balance, FILE_PATH)
  end

  FILE_PATH = 'balance.txt'

  balance = 0
  
  def check_if_file_exists()
    if File.exist?(FILE_PATH)
      file = File.open(FILE_PATH)
      @balance = file.read.to_f
      file.close
    else
      File.write(FILE_PATH, "100.0")
      file = File.open(FILE_PATH)
      @balance = file.read.to_f
      file.close
    end
  end

  def deposit(user_balance)
    loop do
      print "Enter the amount of the deposit: "
      deposit_input = gets.chomp
      if deposit_input[/\A[+-]?[0-9]*\.?\d?\d\Z/]
        deposit_input = deposit_input.to_f
        if deposit_input > 0
          user_balance += deposit_input
          show_balance(user_balance)
          return user_balance
          break
        else
          puts "Error. The deposit cannot be negative or equal to zero."
        end
      elsif deposit_input[/\A[+-]?[0-9]*\.?\d+\Z/]
        puts "Error. Enter no more than two decimal places."
      else
        puts "Error. Please enter a number."
      end
    end
  end

  def withdraw(user_balance)
    loop do
      print "Enter withdrawal amount: "
      withdrawal_amount = gets.chomp
      if withdrawal_amount[/\A[+-]?[0-9]*\.?\d?\d\Z/]  
        withdrawal_amount = withdrawal_amount.to_f
        if withdrawal_amount <= user_balance && withdrawal_amount > 0
          user_balance -= withdrawal_amount
          show_balance(user_balance)
          return user_balance
          break
        elsif withdrawal_amount <= 0
          puts "Error. The withdrawal amount must be greater than zero."
        else
          puts "Error. Not enough money."
        end
      elsif withdrawal_amount[/\A[+-]?[0-9]*\.?\d+\Z/]
        puts "Error. Enter no more than two decimal places." 
      else
        puts "Error. Please enter a number."
      end
    end
  end

  def show_balance(user_balance)
    print "Your current balance: " 
    puts user_balance
  end

  def menu(user_balance, file_path)
    loop do
      puts "-------------------------------"
      puts "             Menu\nD - deposit        W - withdraw\nB - balance        Q - quit"
      puts "-------------------------------"
      input = gets
      input ||= 'q'
      input = input.chomp
      case input
      when 'D','d'
        user_balance = deposit(user_balance)
      when 'W','w'
        user_balance = withdraw(user_balance)
      when 'B','b'
        show_balance(user_balance)
      when 'Q','q'
        File.write(file_path, user_balance)
        break
      else
        puts "Error: Please select the correct menu item"
      end
    end
  end
end

atm = CashMachine.new