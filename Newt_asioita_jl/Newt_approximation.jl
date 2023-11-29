include("dual_numbers.jl")
function diff(f::Function, value::Number)
    f_output = f(Dual(value, 1))
    (f_output.real, f_output.eps)
end
function Newt_aprx(f::Function, iterat::Integer, new_apx::Number)
    for i in 1:iterat
        (output, diff_output) = diff(f, new_apx)
        new_apx = new_apx - output / diff_output# Xn+1 = Xn - f(x)/f'(x)
    end
    accuracy = abs(f(new_apx))
    return (new_apx, accuracy) #Arvon palautus tuplena
end

