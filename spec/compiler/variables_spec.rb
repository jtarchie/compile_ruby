require 'spec_helper'

describe "handle variables" do
  it "can assign variables" do
    compile!("age=1").should == "int value() {int age=1; return age;}"
    compile!("age=1+1").should == "int value() {int age=1+1; return age;}"
  end

  it "can use variables in an expression" do
    compile!("age=1;age+1").should == "int value() {int age=1; return age+1;}"
    compile!("age=1+1;age+1").should == "int value() {int age=1+1; return age+1;}"
  end
end
