module CompileRuby
  class Parser
    attr_accessor :code

    def initialize(code)
      @code = code
    end

    def run!
      @klass ||= begin
        klass_name = "DummyClass#{Time.now.to_f.to_s.gsub(/\D/,'')}"
        klass = Object.const_set(klass_name, Class.new)

        code = @code #scoping issues
        klass.class_eval do
          inline(:C) do |builder|
            builder.add_compile_flags '-x c++', '-lstdc++'
            builder.c Compiler.new(code).compile!
          end
        end
        klass
      end
      @klass.new.value.to_s
    end
  end
end

