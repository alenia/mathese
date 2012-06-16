module Sums
=begin
  in laTeX:
  $\sum_{i=low_val}^high_val method$
  method is a proc.
  examples:
    sigma(1, 5, ->(i) { i }) = 1+2+3+4+5 = 15
=end
  def sigma(low_int, high_int, method) 
    sum = 0
    (low_int..high_int).each { |i| sum += method.call(i) } #figure out argument error
    sum
  end
end
