require 'rspec'
require './lab3_1.rb'

RSpec.describe "script1" do 
  it "if the word ends with “CS” - displays the number 2 to the power of the length of the entered word, otherwise displays the word backwards" do 
    allow_any_instance_of(Kernel).to receive(:gets).and_return('physics')
    expect(script1).to eq("Число 2 в степени 7 = 128")
  end
  
  it "if the word ends with “CS” - displays the number 2 to the power of the length of the entered word, otherwise displays the word backwards" do 
    allow_any_instance_of(Kernel).to receive(:gets).and_return('computer')
    expect(script1).to eq("Слово computer задом наперёд: retupmoc")
  end
end

