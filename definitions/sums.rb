class Sums
  attr_accessor :low, :high, :expression

  def initialize(low, high, expression)
    @low = low
    @high = high
    @expression = expression
  end

  def to_latex
    "$#{'\s'}um_{i=#{@low}}^#{@high} #{@expression}$"
  end

  def evaluate
    sum = 0
    (@low..@high).each { |i| sum += @expression.call(i) }
    sum
  end

  def self.required_arguments
    {low: :integer, high: :integer, expression: :proc}
  end
end
