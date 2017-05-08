require 'bigdecimal'

module RPN
  class Value
    attr_reader :content

    def initialize(content)
      @content = BigDecimal.new(content)
    end

    def apply_to(stack)
      stack.push(self)
    end

    def binary_operation(operator, other)
      result_content = self.content.send(operator, other.content).to_s
      self.class.new(result_content)
    end

    def ==(other)
      content == other.content
    end

    def to_s
      content.to_s('F')
    end

    def method_missing(method, *args)
      potential_operator = method.id2name

      if RPN::BINARY_OPERATORS.include?(potential_operator)
        other = args[0]
        binary_operation(potential_operator, other)
      else
        super
      end
    end
  end
end
