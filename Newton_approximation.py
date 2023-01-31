from sympy import diff, Symbol, simplify, Float, Abs, I, re, im
x = Symbol('x')
p = x**5 -x**4+ 2*x**3-x**2-x
p1 = x**3 -x +1
def Newt_aprx (expr, diffexpr, iterat, guess): 
    #diffexpr = diff(expr) # otetaan funktion derivaatta
    new_apx = guess
    for i in range(iterat):#loopataan nii monta kertaa ku kerrotaan
        new_apx = new_apx - (expr.subs(x, new_apx)/diffexpr.subs(x, new_apx)) #Xn+1 = Xn - f(x)/f'(x)
        new_apx = simplify(new_apx) #sieventää laskun
    accuracy = Float(Abs(simplify(expr.subs(x, new_apx))), 10) #laskun tarkkuus
    return (float(re(new_apx))+float(im(new_apx))*I, accuracy) #palauta kompleksiluku tuplena
    
#print(Newt_aprx(p, 6, 0.7))