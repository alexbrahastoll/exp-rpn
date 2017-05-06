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

    def ==(other)
      content == other.content
    end

    def to_s
      content.to_s('F')
    end
  end
end
