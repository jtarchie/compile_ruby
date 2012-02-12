require 'spec_helper'

describe "handles literals" do
  context "with numerical values" do
    it "can use integers" do
      compile!("1").should == "int value() {return 1;}"
      compile!("10").should == "int value() {return 10;}"
      compile!("12").should == "int value() {return 12;}"
    end

    it "can use doubles" do
      compile!("1.12").should == "double value() {return 1.12;}"
      compile!("10.45").should == "double value() {return 10.45;}"
      compile!("12.67").should == "double value() {return 12.67;}"
    end
  end
end

