using Symbolics
@variables x
q = x^5 - x^4 + 2 * x^3 - x^2 - x
p2 = x^5 - 1 / 3 * x^4 + 2 * x^3 - x
function numfloat(num)
    num = complex(real(num).val, imag(num).val)
    return num
end
function diff(expr, times) #function joka derivoi
    D = Differential(x)^times
    diffexpr = expand_derivatives(D(expr))
    return diffexpr
end

function quadratic_aprx(expr, iter, new_apx, pm)
    diffexpr = diff(expr, 1)
    diffexpr2 = diff(expr, 2)
    if diffexpr2 === 0
        error("Second derivative of ", expr, " is 0")
    end
    for i in 1:iter
        dict = Dict(x => new_apx)
        sub = numfloat(substitute(expr, dict))
        diffsub = numfloat(substitute(diffexpr, dict))
        diff2sub = numfloat(substitute(diffexpr2, dict))
        new_apx = new_apx + (-diffsub + (-1)^pm * sqrt(diffsub^2 - 2 * sub * diff2sub)) / diff2sub
    end
    accuracy = @fastmath abs(substitute(expr, Dict(x => new_apx)))
    return (new_apx, accuracy)
end
quadratic_aprx(x^3 + x^2 - 2, 3, complex(0.5, 1), false)