FILE_PATH = 'balance.txt'

class CashMachine
  def initialize(file_path)
  	check_if_file_exists(file_path)
  end

  balance = 0
  
  def check_if_file_exists(file_path)
    if File.exist?(file_path)
      file = File.open(file_path)
      @balance = file.read.to_f
      file.close
    else
      File.write(file_path, "100.0")
      file = File.open(file_path)
      @balance = file.read.to_f
      file.close
    end
  end

  def deposit(value,file_path)
    deposit_input = value
    if deposit_input[/\A[+-]?[0-9]*\.?\d?\d\Z/]
      deposit_input = deposit_input.to_f
      if deposit_input > 0
        @balance += deposit_input
        File.write(file_path, @balance)
        return show_balance
      else
        return "Error. The deposit cannot be negative or equal to zero."
      end
    elsif deposit_input[/\A[+-]?[0-9]*\.?\d+\Z/]
      return "Error. Enter no more than two decimal places."
    else
      return "Error. Please enter a number."
    end
  end

  def withdraw(value,file_path)
    withdrawal_amount = value
    if withdrawal_amount[/\A[+-]?[0-9]*\.?\d?\d\Z/]  
      withdrawal_amount = withdrawal_amount.to_f
      if withdrawal_amount <= @balance && withdrawal_amount > 0
        @balance -= withdrawal_amount
        File.write(file_path, @balance)
        return show_balance
      elsif withdrawal_amount <= 0
        return "Error. The withdrawal amount must be greater than zero."
      else
        return "Error. Not enough money."
      end
    elsif withdrawal_amount[/\A[+-]?[0-9]*\.?\d+\Z/]
      return "Error. Enter no more than two decimal places." 
    else
      return "Error. Please enter a number."
    end
  end

  def show_balance
    return "Your current balance: #{@balance}"
  end
end