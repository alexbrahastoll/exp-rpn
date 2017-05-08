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
      result_content = content.send(operator, other.content).to_s
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

    def respond_to_missing?(method_name, include_private = false)
      RPN::BINARY_OPERATORS.include?(method_name.to_s) || super
    end
  end
end
