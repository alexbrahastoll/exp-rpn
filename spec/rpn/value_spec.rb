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

      value.apply_to(stack)

      expect(stack.pop).to eq(value)
    end
  end

  describe 'binary operators' do
    ['+', '-', '*', '/'].each do |binary_operator|
      it "does correctly compute #{binary_operator}" do
        value = RPN::Value.new('4')
        other_value = RPN::Value.new('2')
        expected_value_content = eval("4 #{binary_operator} 2").to_s
        expected_value = RPN::Value.new(expected_value_content)

        result = value.send(binary_operator, other_value)

        expect(result).to eq(expected_value)
      end
    end
  end

  describe '#==' do
    context 'when compared to a Value that has the same content' do
      it 'does return true' do
        value = RPN::Value.new('1')
        other_value = RPN::Value.new('1')

        expect(value).to eq(other_value)
      end
    end

    context 'when compared to a Value that has a different content' do
      it 'does return false' do
        value = RPN::Value.new('1')
        other_value = RPN::Value.new('2')

        expect(value).not_to eq(other_value)
      end
    end
  end

  describe '#to_s' do
    it 'does have a coherent string representation' do
      value = RPN::Value.new('-1')

      expect(value.to_s).to eq('-1.0')
    end
  end
end
