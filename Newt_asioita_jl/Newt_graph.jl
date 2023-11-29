include("Newt_roots.jl")
using Plots
p(x) = x^4 - 1
function Newt_graph(f::Function)
    points = Newt_roots(f, 3, 5) #löydetään juuret
    plot(points, seriestype=:scatter, framestyle=:origin, label="roots") #plottaa juuret
end