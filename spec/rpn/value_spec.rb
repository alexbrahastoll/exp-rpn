require 'spec_helper'

RSpec.describe RPN::Value do
  describe '#initialize' do
    it 'does represent its content as a BigDecimal' do
      value = RPN::Value.new('2')
      expected_content = BigDecimal.new('2')

      expect(value.content).to eq(expected_content)
    end
  end

  describe '#apply_to' do
    it 'does push itself to the stack' do
      stack = RPN::Stack.new
      value = RPN::Value.new('3.75')
      expected_stack_state = BigDecimal.new('3.75')

      value.apply_to(stack)

      expect(stack.pop).to eq(value)
    end
  end

  describe '#to_s' do
    it 'does have the same string representation as a BigDecimal' do
      value = RPN::Value.new('-1')

      expect(value.to_s).to eq('-1.0')
    end
  end
end
