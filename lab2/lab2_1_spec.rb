require 'rspec'
require './lab2_1.rb'

RSpec.describe "greeting" do 
  context "when age >= 18"do
		it "welcomes depending on age" do 
		  allow_any_instance_of(Kernel).to receive(:gets).and_return('Иван', 'Иванов', '20')
		  expect{greeting}.to output("Введите имя:\nВведите фамилию:\nВведите возраст:\nПривет, Иван Иванов. Самое время заняться делом!\n").to_stdout
		end
  end

  context "when age < 18" do
		it "welcomes depending on age" do 
		  allow_any_instance_of(Kernel).to receive(:gets).and_return('Пётр', 'Петров', '16')
		  expect{greeting}.to output("Введите имя:\nВведите фамилию:\nВведите возраст:\nПривет, Пётр Петров. Тебе меньше 18 лет, но начать учиться программировать никогда не рано!\n").to_stdout
		end
  end
end
