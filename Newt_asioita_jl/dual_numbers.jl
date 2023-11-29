import Base.+, Base.-, Base.*, Base./, Base.log, Base.^, Base.sin, Base.cos, Base.tan, Base.asin, Base.acos, Base.atan, Base.sinh, Base.cosh, Base.tanh
struct Dual
    real::Number
    eps::Number
end

function +(a::Dual, b::Dual)::Dual
    return Dual(a.real + b.real, a.eps + b.eps)::Dual
end
function +(a::Dual, b::Number)::Dual
    return Dual(a.real + b, a.eps)
end
function +(a::Number, b::Dual)::Dual
    return Dual(a + b.real, b.eps)
end

function -(a::Dual, b::Dual)::Dual
    return Dual(a.real - b.real, a.eps - b.eps)
end
function -(a::Dual, b::Number)::Dual
    return Dual(a.real - b, a.eps)
end
function -(a::Number, b::Dual)::Dual
    return Dual(a - b.real, b.eps)
end


function *(a::Dual, b::Dual)::Dual
    return Dual(a.real * b.real, a.real * b.eps + a.eps * b.real)
end
function *(a::Dual, b::Number)::Dual
    return Dual(a.real * b, a.eps * b)
end
function *(a::Number, b::Dual)::Dual
    return Dual(a * b.real, a * b.eps)
end

function /(a::Dual, b::Dual)::Dual
    return Dual(a.real / b.real, (a.eps * b.real - a.real * b.eps) / (a.real)^2)
end
function /(a::Dual, b::Number)::Dual
    return Dual(a.real / b, a.eps / b)
end
function /(a::Number, b::Dual)::Dual
    return Dual(a / b.real, -a * b.eps / b.real^2)
end

function ^(a::Dual, b::Dual)::Dual
    return Dual(a.real^b.real, a.real^b.real * (b.eps * log(a.real) + a.eps * b.real / a.real))
end
function ^(a::Dual, b::Number)::Dual
    return Dual(a.real^b, b * a.real^(b - 1) * a.eps)
end
function ^(a::Number, b::Dual)::Dual
    return Dual(a^b.real, a^b.real * log(a))
end

function log(a::Dual)::Dual
    return Dual(log(a.real), a.eps / a.real)
end
function Log(b::Real, a::Dual)::Dual
    if b < 0
        return DomainError(b, "negative base is not defined for the reals")
    end
    return Dual(log(b, a.real), a.eps / (a.real * log(b)))
end
function Log(a::Dual, b::Dual)::Dual
    return log(a) / log(b)
end

function sin(a::Dual)::Dual
    Dual(sin(a.real), cos(a.real) * a.eps)
end
function cos(a::Dual)::Dual
    Dual(cos(a.real), -sin(a.real) * a.eps)
end
function tan(a::Dual)::Dual
    Dual(tan(a.real), a.eps / (cos(a.real))^2)
end

function asin(a::Dual)::Dual
    if abs(a.real) > 1
        return DomainError(a.real, "asin(x) is not defined for |x|>1")
    end
    return Dual(asin(a.real), a.eps / sqrt(1 - a.real^2))
end
function acos(a::Dual)::Dual
    if abs(a.real) > 1
        return DomainError(a.real, "acos(x) is not defined for |x|>1")
    end
    return Dual(asin(a.real), -a.eps / sqrt(1 - a.real^2))
end
function atan(a::Dual)::Dual
    return Dual(atan(a.real), a.eps / (a.real^2 + 1))
end

function sinh(a::Dual)::Dual
    return Dual(sinh(a.real), cosh(a.real) * a.eps)
end
function cosh(a::Dual)::Dual
    return Dual(cosh(a.real), sinh(a.real) * a.eps)
end
function tanh(a::Dual)::Dual
    return Dual(tanh(a.real), a.eps / (cosh(a.real)^2))
end