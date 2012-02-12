module CompileRuby
  class PreservedArray < Array
    def pop
      if self.length == 1
        last
      else
        super
      end
    end
  end
end
