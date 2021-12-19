require 'rspec'
require 'tempfile'
require './atm.rb'
require './answer.rb'

RSpec.describe CashMachine do 
  let(:test_file) {Tempfile.new(['test_file', '.txt'])}
  let(:cashmachine){CashMachine.new(test_file)}

  before do
    File.write(test_file, 5000)
    cashmachine.check_if_file_exists(test_file)
  end

  after do
    test_file.unlink
  end

  describe 'deposit' do
    context 'when the deposit amount is entered correctly' do
      it 'adds the amount of the deposit to the current balance' do
        expect(cashmachine.deposit('500',test_file)).to eq("Your current balance: 5500.0")
      end
    end

    context 'when trying to enter a negative deposit amount' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        expect(cashmachine.deposit('-500',test_file)).to eq("Error. The deposit cannot be negative or equal to zero.")
      end
    end

    context 'when the deposit amount contains more than two decimal places' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        expect(cashmachine.deposit('123.456789',test_file)).to eq("Error. Enter no more than two decimal places.")
      end
    end

    context 'when the deposit amount is not a number' do
      it 'displays an error and asks to enter the correct amount of the deposit' do
        expect(cashmachine.deposit('A',test_file)).to eq("Error. Please enter a number.")
      end
    end
  end  

  describe 'withdraw' do
    context 'when the withdrawal amount is entered correctly' do
      it 'subtracts the withdrawal amount from the balance' do
        expect(cashmachine.withdraw('500',test_file)).to eq("Your current balance: 4500.0")
      end
    end

    context 'when the withdrawal amount is less than zero' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        expect(cashmachine.withdraw('-500',test_file)).to eq("Error. The withdrawal amount must be greater than zero.")
      end
    end

    context 'when there is not enough money on the balance' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        expect(cashmachine.withdraw('10000',test_file)).to eq("Error. Not enough money.")
      end
    end

    context 'when the withdrawal amount contains more than two decimal places' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        expect(cashmachine.withdraw('123.456789',test_file)).to eq("Error. Enter no more than two decimal places.")
      end
    end

    context 'when the withdrawal amount is not a number' do
      it 'displays an error and asks to enter the correct withdrawal amount' do
        expect(cashmachine.withdraw('A',test_file)).to eq("Error. Please enter a number.")
      end
    end
  end

  describe 'show_balance' do
    it 'displays the balance' do
      expect(cashmachine.show_balance).to eq("Your current balance: 5000.0")
    end
  end
end

RSpec.describe "http-server" do
  let(:test_file) {Tempfile.new(['test_file', '.txt'])}
  let(:cashmachine){CashMachine.new(test_file)}
  let(:test_answer){"HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<title>"}

  before do
    File.write(test_file, 5000)
    cashmachine.check_if_file_exists(test_file)
  end

  after do
    test_file.unlink
  end

  describe 'show_answer' do
    it 'deposit' do
      expect(show_answer(cashmachine, ["GET", "/deposit?value=500", "HTTP/1.1"], "/deposit", '500', test_file)).to eq(test_answer+"deposit</title>Your current balance: 5500.0")
    end

    it 'withdraw' do
      expect(show_answer(cashmachine, ["GET", "/withdraw?value=500", "HTTP/1.1"], "/withdraw", '500', test_file)).to eq(test_answer+"withdraw</title>Your current balance: 4500.0")
    end

    it 'balance' do
      expect(show_answer(cashmachine, ["GET", "/balance", "HTTP/1.1"], "/balance", '0', test_file)).to eq(test_answer+"balance</title>Your current balance: 5000.0")
    end
  end
end