class Summation
  attr_accessor :low, :high, :expression

  def initialize(low, high, expression)
    @low = low
    @high = procify(high)
    @expression = procify(expression)
  end

  def evaluate
    result = proc do |x|
      h = @high.call(x)
      evaluate_with_integers(@low, h)
    end
    deprocify(result)
  end

  private

  def evaluate_with_integers(l,h)
    sum = { l - 1 => proc {0} } # whacky hash eliminates whacky closure madness.
    (l..h).each do |i|
      sum[i] = proc do |k|
        sum[i-1].curry[k] + @expression.curry[i, k]
      end
    end
    deprocify(sum[h])
  end

  def procify(number_or_proc)
    number_or_proc.respond_to?(:call) ? number_or_proc : proc { |i| number_or_proc }
  end

  def deprocify(p)
    begin
      p.call
    rescue #TODO: yikes! Figure out another nice way of making this work.
      # curry[] doesn't work for a proc with one argument
      p
    end
  end
end

#\sum_{a=1}^{5}(\sum_{i=1}^{5}i+a)
