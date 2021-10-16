require 'rspec'
require './lab2_2.rb'

RSpec.describe "foobar" do 
  it "if at least one number is 20 - it returns the second number, otherwise it returns the sum of these numbers" do 		
	expect(foobar(20,1)).to eq(1)
  end

  it "if at least one number is 20 - it returns the second number, otherwise it returns the sum of these numbers" do 
	expect(foobar(5,20)).to eq(5)
  end

  it "if at least one number is 20 - it returns the second number, otherwise it returns the sum of these numbers" do 
	expect(foobar(4,5)).to eq(9)
  end
end

