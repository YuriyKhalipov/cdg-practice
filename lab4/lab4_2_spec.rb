require 'rspec'
require 'tempfile'
require './lab4_2.rb'

RSpec.describe "Methods for working with files" do 
  let(:test_file) {Tempfile.new(['test_file', '.txt'])}
  let(:test_results) {Tempfile.new(['test_results', '.txt'])}
  let(:students){"Иван Иванов 19\nПётр Петров 21\nМария Кузнецова 20\nДмитрий Соколов 21\nАлександр Смирнов 18\n" +
  "Виктория Лебедева 20\nМихаил Воробьёв 19\nМаксим Волков 18\nАнна Соловьёва 21\nВладимир Новиков 20\n"}
  let(:test_indexes){[0,6]}
  let(:test_indexes2){[]}
  let(:test_arr){[]}
  let(:students_arr){["Иван Иванов 19\n", "Пётр Петров 21\n", "Мария Кузнецова 20\n", "Дмитрий Соколов 21\n", "Александр Смирнов 18\n",
  "Виктория Лебедева 20\n", "Михаил Воробьёв 19\n", "Максим Волков 18\n", "Анна Соловьёва 21\n", "Владимир Новиков 20\n"]}

  before do  
    File.write(test_file , students)
    File.write(test_results , "Александр Смирнов 18\nМаксим Волков 18\n")
  end

  after do
    test_file.unlink
  end

  it "outputs all lines" do 
    expect{index(test_file)}.to output(students).to_stdout
  end

  describe 'where' do
    context "when using an existing pattern" do
      it "finds all lines containing a pattern" do 
        expect(where('19', test_file)).to eq(test_indexes)
      end
    end

    context "when using a non-existent pattern" do
    it "doesn't find any lines" do 
        expect(where('0', test_file)).to eq(test_indexes2)
      end
    end
  end

  it "copies the file data to an array" do 
    expect(file_to_array(test_arr, test_file)).to eq(students_arr)
  end

  describe 'write' do
    context "when adding new lines to the file" do
      it "writes lines to the file" do 
        write(students_arr, where('19', test_file), test_results)
        expect{index(test_results)}.to output("Александр Смирнов 18\nМаксим Волков 18\nИван Иванов 19\nМихаил Воробьёв 19\n").to_stdout
      end
    end

    context "when adding an existing lines to the file" do
      it "doesn't write lines to the file" do 
        write(students_arr, where('18', test_file), test_results)
        expect{index(test_results)}.to output("Александр Смирнов 18\nМаксим Волков 18\n").to_stdout
      end
    end

    context "when adding a nonexistent line to the file" do
      it "doesn't write lines to the file" do 
        write(students_arr, where('0', test_file), test_results)
        expect{index(test_results)}.to output("Александр Смирнов 18\nМаксим Волков 18\n").to_stdout
      end
    end
  end
end

