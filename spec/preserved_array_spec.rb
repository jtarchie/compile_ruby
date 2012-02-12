require 'spec_helper'

describe CompileRuby::PreservedArray do
  it "inherits from Array" do
    CompileRuby::PreservedArray.new.should be_kind_of(Array)
  end

  context "when taking off the stack" do
    context "with multiple values" do
      let(:stack) do
        s = CompileRuby::PreservedArray.new
        s << :a
        s << :b
        s
      end

      it "just keeps taking the last value" do
        stack.length.should == 2
        stack.pop.should == :b
        stack.pop.should == :a

        stack.length.should == 1
        stack.pop.should == :a
      end
    end
  end
end
