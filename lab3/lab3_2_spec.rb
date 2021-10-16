require 'rspec'
require 'stringio'
require './lab3_2.rb'

RSpec.describe "script2" do 
  before do
    allow($stdout).to receive(:write)
  end

  it "Prints to the console an array containing pokemon hashes " do 
    allow_any_instance_of(Kernel).to receive(:gets).and_return("5", "pokemon1", "yellow" , "pokemon2", "green", "pokemon3", "blue", "pokemon4", "red", "pokemon5", "orange")
    expect(script2).to eq([{:name=>"pokemon1", :color=>"yellow"}, {:name=>"pokemon2", :color=>"green"}, {:name=>"pokemon3", :color=>"blue"}, {:name=>"pokemon4", :color=>"red"}, 
    {:name=>"pokemon5", :color=>"orange"}])
  end
end



