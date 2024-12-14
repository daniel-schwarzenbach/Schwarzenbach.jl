module Schwarzenbach
    import Base
    import Base.^

    ∞::Real = Inf
    export ∞

  # Mathematische notationen
    """
    The set of all DataTypes
    """
    𝕏 = Any
    export 𝕏
    """
    The set of Real numbers
    """
    ℝ = Real
    export ℝ

    """
    The set of Complex Number or all Numbers
    """
    ℂ = Number
    export ℂ

    """
    The set of Integer Numbers
    """
    ℤ = Integer
    export ℤ

    """
    The set of Natural Numbers
    """
    ℕ = Unsigned
    export ℕ

    ∅ = Nothing
    export ∅

    ø = nothing
    export ø

    ℝⁿ = AbstractVector{ℝ}
    ℂⁿ = AbstractVector{ℂ}
    export ℝⁿ
    export ℂⁿ

    ℝⁿˣᵐ = AbstractMatrix{ℝ}
    ℂⁿˣᵐ = AbstractMatrix{ℂ}
    export ℝⁿˣᵐ
    export ℂⁿˣᵐ

    """
    ℂ → ℂ

    x ↦ log|x|
    """
    logabs(x::ℂ)::ℂ = log(abs(x))
    export logabs
    
    """
    ℂ → ℂ

    x ↦ log|x|
    """
    function logc(x::ℂ) ::ℂ
        if x >= +0.
            return log(x)
        else
            return log(x + Complex(0.0, 1e-10))
        end
    end
    export logc

    (^)(x::AbstractFloat, n::ℂ) = exp(logc(x)*n)
    (^)(x::Complex, n::ℂ) = exp(logc(x)*n)
    export ^

    function ⋅(a::ℂ, b::ℂ)::ℂ
        return a * b
    end
    
    function ⋅(a::Vector{T}, b::Vector{T}) ::T  where T
        return sum([a[i] * b[i] for i in 1:length(a)])
    end
    export ⋅
    
    function ×(a::Vector, b::Vector)::Vector
        s::ℤ = length(a)
        c = zeros(s)
        for i in 1:(s-2)
            c[i] = a[i+1] * b[i+2] - a[i+1] * b[i+2]
        end
        c[s-1]= a[s] * b[1]  -  a[1] * b[s]
        c[s]  = a[1] * b[2]  -  a[2] * b[1]
        return c
    end
    export ×
    
    function ⊙(a::Vector, b::Vector) ::Vector
        return [a[i] * b[i] for i in 1:length(a)]
    end
    export ⊙

  

    """
    function that prints the expression and its evaluations

    Example:

    ⁠>  what_is(3^3)

    ⁠<  3^3 = 27
    """
    function what_is(expr::String)
        # Evaluate the expression
        result = eval(Meta.parse(expr))
        # Print the expression and its evaluation
        println("$expr = $result")
    end
    export what_is

    macro echo(expr)
        return quote
            # Print the expression as entered
            println($(string(expr)), " = ", $(esc(expr)))
        end
    end
    export @echo

    macro swap!(a,b)
      quote
          tmp = $(esc(a))
          $(esc(a)) = $(esc(b))
          $(esc(b)) = tmp
      end
    end
    export @swap!
  

    """
    OR operator: a ∨ b
    """
    function ∨(a::T, b::T) where T
        return T(Bool(a) || Bool(b))
    end
    export ∨

    """
    AND operator: a ∧ b
    """
    function ∧(a::T, b::T) ::T where T
        if Bool(a)
            return T(Bool(b))
        else
            return T(false)
        end
    end
    export ∧

    """
    NOT operator: ¬a ≡ !a
    """
    function ¬(a::T) ::T where T
        return T(!Bool(a))
    end
    export ¬

    """
    NOR operator: a ↓ b ≡ ¬(a ∨ b)
    """
    function ↓(a::T, b::T) ::T where T
        return T(!(Bool(a) || Bool(b)))
    end
    export ↓

    """
    NAND operator: a ↑ b ≡ ¬(a ∧ b)
    """
    function ↑(a::T, b::T) ::T where T
        return T(!(Bool(a) && Bool(b)))
    end
    export ↑

    """
    XOR operator: a ⊕ b ≡ (a∨b) ∧ (a↑b)
    """
    function ⊕(a::T, b::T) ::T where T
        return (a∨b) ∧ (a↑b)
    end
    export⊕

    """
    Logical implication \\rightarrow operator: a ⟶ b ≡ ¬a ∨ b
    """
    function →(a,b)
        return ¬a ∨ b
    end
    export→

    """
    Logical reverse-implication \\leftarrow operator: a ⟵ b ≡ b ⟶ a
    """
    function ←(a,b)
        return b → a
    end
    export ←

    """
    Logical equivalent \\leftrightarrow operator: a ⟷ b ≡ (a ⟶ b) ∧ (b ⟶ a)
    """
    function ↔(a,b)
        return (a → b) ∧ (b → a)
    end
    export ↔

    """
    ```julia
    test_logical_function(fn::Function, argC::ℤ) -> ∅
    ```
    This function tests a logical function `logicalFunction` by evaluating it for all possible combinations of Boolean inputs, 
    given the number of arguments `argC`. The function prints the result for each combination in a readable format.

    # Arguments:
    - `fn::Function`: The logical function to be tested. It should accept `argC` Boolean arguments.
    - `argC::Int`: The number of arguments the logical function accepts.

    # Behavior:
    - Generates all possible combinations of `true` and `false` for the specified number of arguments (`argC`).
    - Evaluates the logical function with each combination of inputs.
    - Prints the input combination and the corresponding output in the format: `H(input1, input2, ...) = result`.

    # Example:
    ```julia
    H(A, B, C) = (A → (B ∨ C)) → ((A → B) ∨ (A → C))
    test_logical_function(H, 3)
    # Output:
    # H(true, true, true) = true
    # H(true, true, false) = true
    # H(true, false, true) = true
    # H(true, false, false) = true
    # H(false, true, true) = true
    # H(false, true, false) = true
    # H(false, false, true) = true
    # H(false, false, false) = true
    ````
    """
    function test_logical_function(fn::Function, argC::ℤ) ::∅
        # Generate all combinations of true/false for `argC` arguments
        combinations = Iterators.product(fill((true, false), argC)...)
        
        # Evaluate the function for each combination and print it
        for inputs in combinations
            result = fn(inputs...)
            println("$fn($(join(inputs, ", "))) = $result")
        end
    end
    export test_logical_function

end # module Schwarzenbach

