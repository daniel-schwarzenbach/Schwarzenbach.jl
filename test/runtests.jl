using Schwarzenbach
using Test

@testset "Schwarzenbach.jl" begin
    # Write your tests here.
    a::ℤ = 7
    a ← 9
    @test a ≡ 9
    @test √(64) ≡ 8
    @test abs(64.0^0.5 - 8.0) <= 0.1
    @test logabs(-1) ≡ 0

    @test [1, 0, 0] × [0, 1, 0] ≡ [0, 0, 1]
    @test [1, 0, 0] ⊙ [2, 1, 0] ≡ [2, 0, 0]
    @test [1, 0, 0] ⋅ [2, 1, 0] ≡  2

    @test 0 ↑ 1
    @test 0 ↓ 0
    @test 1 ∧ 1
    @test 1 ∨ 0

end
