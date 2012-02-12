module CompileRuby
  class Compiler
    attr_reader :sexp

    def initialize(code)
      @sexp = RubyParser.new.parse(code)
    end

    def compile!
      @inferred_type = "int"
      compiled_statement = compile(@sexp)
      "#{@inferred_type} value() {return #{compiled_statement};}"
    end

    private

    def compile(sexp)
      send("handle_#{sexp.sexp_type}", sexp.sexp_body)
    end

    def handle_arglist(sexp)
      sexp.collect do |s|
        compile(s)
      end.join(',')
    end

    def handle_call(sexp)
      receiver, operation, arglist = sexp

      compile(receiver) +
        operation.to_s +
        compile(arglist)
    end

    def handle_lit(sexp)
      @inferred_type = "double" if sexp.sexp_type.is_a?(Float)
      "#{sexp.sexp_type}"
    end
  end
end

