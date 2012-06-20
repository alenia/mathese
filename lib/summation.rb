class Summation
  attr_accessor :low, :high, :expression

  def initialize(low, high, expression)
    @low = low
    @high = high
    @expression = initialize_expression(expression)
  end

  def evaluate
    sum = { @low - 1 => proc {0} } # whacky hash eliminates whacky closure madness.
    (@low..@high).each do |i|
      sum[i] = proc do |k|
        sum[i-1].curry[k] + @expression.curry[i, k]
      end
    end
    begin
      sum[@high].call
    rescue TypeError
      sum[@high]
    end
  end

  private

  def initialize_expression(expression)
    expression.respond_to?(:call) ? expression : proc { |i| expression }
  end
end

#\sum_{a=1}^{5}(\sum_{i=1}^{5}i+a)
