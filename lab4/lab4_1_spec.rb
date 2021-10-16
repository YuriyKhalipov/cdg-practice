require 'rspec'
require './lab4_1.rb'

RSpec.describe "Methods for working with files" do 
  let(:students){"Иван Иванов 19\nПётр Петров 21\nМария Кузнецова 20\nДмитрий Соколов 21\nАлександр Смирнов 18\n" +
  "Виктория Лебедева 20\nМихаил Воробьёв 19\nМаксим Волков 18\nАнна Соловьёва 21\nВладимир Новиков 20\n"}
  let(:students2){"Иван Иванов 19\nПётр Петров 20\nМария Кузнецова 20\nДмитрий Соколов 21\nАлександр Смирнов 18\n" +
  "Виктория Лебедева 20\nМихаил Воробьёв 19\nМаксим Волков 18\nАнна Соловьёва 21\nВладимир Новиков 20\n"}
  let(:students3){"Иван Иванов 19\nМария Кузнецова 20\nДмитрий Соколов 21\nАлександр Смирнов 18\n" +
  "Виктория Лебедева 20\nМихаил Воробьёв 19\nМаксим Волков 18\nАнна Соловьёва 21\nВладимир Новиков 20\n"}
  let(:test_indexes){[0,6]}
  
  before do  
    File.write('test.txt' , students)
  end

  after do
    File.delete('test.txt') if File.exist?('test.txt')
  end

  it "all lines output" do 
    expect{index}.to output(students).to_stdout
  end

  it "outputs the line" do 
    expect{find(1)}.to output("Пётр Петров 21\n").to_stdout
    expect{find(9)}.to output("Владимир Новиков 20\n").to_stdout
    expect{find(5)}.to output("Виктория Лебедева 20\n").to_stdout
  end

  it "finds all lines containing a pattern" do 
    expect(where('19')).to eq(test_indexes)
  end

  it "updates the line" do 
    update(1, 'Пётр Петров 20')
    expect{index}.to output(students2).to_stdout
    expect(File.exist?(BUFFER)).to eq(false)
  end

  it "deletes the line" do 
    delete(1)
    expect{index}.to output(students3).to_stdout
    expect(File.exist?(BUFFER)).to eq(false)
  end
end