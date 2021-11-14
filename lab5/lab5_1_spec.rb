require 'rspec'
require 'tempfile'
require './lab5_1.rb'

RSpec.describe CashMachine do 
  let(:test_balance) {250.0}
  let(:test_file) {Tempfile.new(['test_file', '.txt'])}
  let(:cashmachine){CashMachine.new}

  after do
    test_file.unlink
  end

  describe 'deposit' do
    context 'when the deposit amount is entered correctly' do
      it 'adds the amount of the deposit to the current balance' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "1500") 
        expect(cashmachine.deposit(test_balance)).to eq(1750)
      end
    end

    context 'when trying to enter a negative deposit amount' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "-100", "100", "-100", "100") 
        expect(cashmachine.deposit(test_balance)).to eq(350)
        expect{cashmachine.deposit(test_balance)}.to output("Enter the amount of the deposit: Error. The deposit cannot be negative or equal to zero.\n"+
        "Enter the amount of the deposit: Your current balance: 350.0\n").to_stdout
      end
    end

    context 'when the deposit amount contains more than two decimal places' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "5000.755", "5000.75", "5000.755", "5000.75") 
        expect(cashmachine.deposit(test_balance)).to eq(5250.75)
        expect{cashmachine.deposit(test_balance)}.to output("Enter the amount of the deposit: Error. Enter no more than two decimal places.\n"+
        "Enter the amount of the deposit: Your current balance: 5250.75\n").to_stdout
      end
    end

    context 'when the deposit amount is not a number' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "word", "10.5", "word", "10.5") 
        expect(cashmachine.deposit(test_balance)).to eq(260.5)
        expect{cashmachine.deposit(test_balance)}.to output("Enter the amount of the deposit: Error. Please enter a number.\n"+
        "Enter the amount of the deposit: Your current balance: 260.5\n").to_stdout
      end
    end
  end  

  describe 'withdraw' do
    context 'when the withdrawal amount is entered correctly' do
      it 'subtracts the withdrawal amount from the balance' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "50") 
        expect(cashmachine.withdraw(test_balance)).to eq(200)
      end
    end

    context 'when the withdrawal amount is less than zero' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "-100", "100", "-100", "100") 
        expect(cashmachine.withdraw(test_balance)).to eq(150)
        expect{cashmachine.withdraw(test_balance)}.to output("Enter withdrawal amount: Error. The withdrawal amount must be greater than zero.\n"+
        "Enter withdrawal amount: Your current balance: 150.0\n").to_stdout
      end
    end

    context 'when there is not enough money on the balance' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "1000", "250", "1000", "250") 
        expect(cashmachine.withdraw(test_balance)).to eq(0)
        expect{cashmachine.withdraw(test_balance)}.to output("Enter withdrawal amount: Error. Not enough money.\n"+
        "Enter withdrawal amount: Your current balance: 0.0\n").to_stdout
      end
    end

    context 'when the withdrawal amount contains more than two decimal places' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "100.555", "100.55", "100.555", "100.55") 
        expect(cashmachine.withdraw(test_balance)).to eq(149.45)
        expect{cashmachine.withdraw(test_balance)}.to output("Enter withdrawal amount: Error. Enter no more than two decimal places.\n"+
        "Enter withdrawal amount: Your current balance: 149.45\n").to_stdout
      end
    end

    context 'when the withdrawal amount is not a number' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "word", "50", "word", "50") 
        expect(cashmachine.withdraw(test_balance)).to eq(200)
        expect{cashmachine.withdraw(test_balance)}.to output("Enter withdrawal amount: Error. Please enter a number.\n"+
        "Enter withdrawal amount: Your current balance: 200.0\n").to_stdout
      end
    end
  end

  describe 'show_balance' do
    it 'displays the balance' do
      expect{cashmachine.show_balance(test_balance)}.to output("-------------------------------\n             Menu\nD - deposit        W - withdraw\nB - balance        Q - quit\n"+
      	"-------------------------------\nYour current balance: 250.0\n").to_stdout
    end
  end

  describe 'menu' do
    context 'when deposit and quit' do
      it 'deposits money and saves the new balance to the file' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "D", "100", "Q")
        cashmachine.menu(test_balance, test_file)
        expect{print test_file.read}.to output("350.0").to_stdout
      end
    end

    context 'when withdraw and quit' do
      it 'withdraws money and saves the new balance to the file' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "W", "100", "Q")
        cashmachine.menu(test_balance, test_file)
        expect{print test_file.read}.to output("150.0").to_stdout
      end
    end

    context 'when deposit, withdraw, balance and quit' do
      it 'deposits money, withdraws money, displays the balance and saves the new balance to the file' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("Q", "D", "500", "W", "100", "B", "Q")
        cashmachine.menu(test_balance, test_file)
        expect{print test_file.read}.to output("650.0").to_stdout
      end
    end
  end
end