module BinomialExpansion
  def pascal(i)
    return [1] if i == 0
    binomial_expansion(i).exponentize.values
  end

  def binomial_expansion(i)
    raise ArgumentError if i < 1
    exp = i == 1 ? ['a','b'] : expand(binomial_expansion(i-1),['a','b'])
    exp.map{|i| i.split('').sort.join('')}.sort
  end

  def expand(arry1,arry2) # assumes array of strings.
    product_array = []
    arry2.each do |i|
      product_array += arry1.map { |j| j + i }
    end
    product_array
  end

end

class Array
  def exponentize
    hash = Hash.new(0)
    self.each do |key|
      hash[key] += 1
    end
    hash
  end
end
