module Schwarzenbach

    import Base.^

    ∞::Real = Inf
    export ∞

    𝔸 = Number
    export 𝔸
    ℝ = Real
    export ℝ
    ℂ = Complex
    export ℂ
    ℤ = Integer
    export ℤ
    ℕ = Unsigned
    export ℕ
    ∅ = nothing
    export ∅

    Fn = Function
    export Fn

    U8   = UInt8
    export U8
    U16  = UInt16
    export U16
    U32  = UInt32
    export U32
    U64  = UInt64
    export U64
    U128 = UInt128
    export U128

    I8   = Int8
    export I8
    I16  = Int16
    export I16
    I32  = Int32
    export I32
    I64  = Int64
    export I64
    I128 = Int128
    export I128

    F32 = Float32
    export F32
    F64 = Float64
    export F64

    ℝⁿ = AbstractVector{ℝ}
    ℂⁿ = AbstractVector{ℂ}
    export ℝⁿ
    export ℂⁿ

    ℝⁿˣᵐ = AbstractMatrix{ℝ}
    ℂⁿˣᵐ = AbstractMatrix{ℂ}
    export ℝⁿˣᵐ
    export ℂⁿˣᵐ

    logabs(x::𝔸) = log(abs(x))
    export logabs

    function logc(x::𝔸)
        if x >= +0.
            return log(x)
        else
            return log(x + ℂ(0.0, 1e-10))
        end
    end
    export logc

    (^)(x::𝔸, n::ℝ) = exp(logc(x)*n)
    (^)(x::𝔸, n::ℂ) = exp(logc(x)*n)
    (^)(x::𝔸, n::𝔸) = 0
    export (^)

    ⎷(x::𝔸)  = sqrt(x)
    export ⎷
    
end