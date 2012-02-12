require 'spec_helper'

describe CompileRuby::Compiler do

  context "#new" do
    let(:value) { "abcd" }
    it "sets the sexp" do
      described_class.new("\"#{value}\"").sexp.should == s(:str, value)
    end
  end

end
