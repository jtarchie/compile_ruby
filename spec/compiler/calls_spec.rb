require 'spec_helper'

describe "handles calls" do
  context "with mathmatical operations" do
    it "with mathematical operations" do
      compile!("1+1").should == "int value() {return 1+1;}"
      compile!("1-1").should == "int value() {return 1-1;}"
      compile!("1*1").should == "int value() {return 1*1;}"
      compile!("1/1").should == "int value() {return 1/1;}"
    end
    it "supports doubleing point math" do
      compile!("12.67+1").should == "double value() {return 12.67+1;}"
      compile!("1+11.12").should == "double value() {return 1+11.12;}"
    end
  end
end
