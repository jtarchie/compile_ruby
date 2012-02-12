require 'spec_helper'

describe "handle variables" do
  it "can assign variables" do
    compile!("age=1").should == "int value() {int age=1; return age}"
    compile!("age=1+1").should == "int value() {int age=1+1; return age}"
  end
end
