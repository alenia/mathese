module BasicRecursiveMethods
  def fib(n)
    n > 1 ? fib(n-1) + fib(n-2) : n
  end
end
