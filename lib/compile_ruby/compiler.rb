module CompileRuby
  class Compiler
    attr_reader :sexp

    def initialize(code)
      @sexp = RubyParser.new.parse(code)
      @inferred_types = PreservedArray.new
      @imply_return = true
    end

    def compile!
      compiled_statement = compile(@sexp)
      inferred_type = @inferred_types.pop || "void"
      last_sexp = @current_sexp.pop
      if last_sexp.sexp_type == :lasgn
        "#{inferred_type} value() {#{compiled_statement} return #{last_sexp.sexp_body.first};}"
      else
        trailing_char = compiled_statement[-1]==";" ? "" : ";"
        "#{inferred_type} value() {#{@imply_return ? 'return ': ''}#{compiled_statement}#{trailing_char}}"
      end
    end

    private

    def compile(sexp)
      @current_sexp ||= PreservedArray.new
      @current_sexp << sexp

      compiled_exp = send("handle_#{sexp.sexp_type}", sexp.sexp_body)

      @current_sexp.pop
      compiled_exp
    end

    def handle_block(sexp)
      expressions = sexp.collect do |s|
        compile(s)
      end
      expressions[-1] = " return #{expressions[-1]}"
      expressions.join('')
    end

    def handle_lvar(sexp)
      sexp.sexp_type.to_s
    end

    def handle_lasgn(sexp)
      @imply_return = false
      name, rhs = sexp
      compiled_statement = compile(rhs)
      "#{@inferred_types.last} #{name}=#{compiled_statement};"
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
      case sexp.sexp_type
      when Float
        @inferred_types << "double"
      when Integer
        @inferred_types << "int" unless @inferred_types.include?("double")
      end
      sexp.sexp_type.to_s
    end
  end
end

