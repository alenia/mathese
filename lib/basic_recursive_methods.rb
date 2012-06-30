module BasicRecursiveMethods
  def fib(n)
    raise ArgumentError if n < 0
    n > 1 ? fib(n-1) + fib(n-2) : n
  end

  def factorial(n)
    raise ArgumentError if n < 0
    n > 1 ? n * factorial(n-1) : n
  end
end
