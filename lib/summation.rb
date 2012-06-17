class Summation
  attr_accessor :low, :high, :expression

  def initialize(low, high, expression)
    @low = low
    @high = high
    @expression = expression
  end

  def to_latex
    iterator = @expression.parameters[0][1]
    "$#{'\s'}um_{#{iterator}=#{@low}}^#{@high} #{@expression}$"
  end

  def evaluate
    sum = 0
    (@low..@high).each { |i| sum += @expression.call(i) }
    sum
  end
end
