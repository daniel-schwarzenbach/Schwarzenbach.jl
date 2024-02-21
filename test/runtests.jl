using Schwarzenbach
using Test

@testset "Schwarzenbach.jl" begin
    # Write your tests here.
    @test ⎷(64) == 8
    @test abs(64.0^0.5 - 8.0) <= 0.1
    @test logabs(-1) == 0
end
