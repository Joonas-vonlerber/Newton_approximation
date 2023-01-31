from sympy import Abs, im, re, Symbol, I, diff, simplify, Float
x = Symbol('x')
p = x**5 -x**4+ 2*x**3-x**2-x
p1 = x**3+ 3*x**2 -2
p2 = x**2 -2
p3 = x**6 -3/2*x**5 -1/2*x**4 -x**3 +12
def Newt_aprx (expr, diffexpr,iterat, guess):
    new_apx = guess
    for i in range(iterat):#loopataan nii monta kertaa ku kerrotaan
        new_apx = new_apx - (expr.subs(x, new_apx)/diffexpr.subs(x, new_apx)) #Xn+1 = Xn - f(x)/f'(x)
        new_apx = simplify(new_apx) #sieventää laskun
    accuracy = Float(Abs(simplify(expr.subs(x, new_apx))), 10) #laskun tarkkuus
    return (float(re(new_apx))+float(im(new_apx))*I, accuracy) #palauta kompleksiluku tuplena

def Newt_roots(expr, radius, iterat):
    rootlist = []
    diffexpr = diff(expr)
    e = 0
    f = 0
    g = 0
    for i in range(-radius, radius+1): #y koordinaatit läpi
        for j in range(-radius, radius+1): #x koordinaatit läpi
            rootlist.append(Newt_aprx(expr, diffexpr, iterat, complex(j,i)))
    #print(len(rootlist))                  
    while e < len(rootlist): #käy koko root lista läpi
        if (str(rootlist[e][1]) == 'nan') or (rootlist[e][1]>0.01): #jos tarkuus on huonompi kuin 0.01 
            rootlist.pop(e) #heitä se pois
        else:
            e += 1
    while f < len(rootlist): #menemme listan läpi
        #print(f+1)
        g = f+1
        while g <len(rootlist): #kahdesti ja vertailemme niitä           
             #print(g+1)
             a = rootlist[f]
             b = rootlist[g]
             distance = Abs((re(b[0])-re(a[0]))+(im(b[0])-im(a[0]))*I) # kahden pisteen etäisyys toisistaan             
             if distance <= 0.01: # jos etäisyys on pienempi tai yhtäsuurikuin 0.01 ja ei ole sama indeksi
                 if a[1] <= b[1]: #heitetään se ulos listasta kummalla on huonompi tarkkuus
                     rootlist.pop(g)
                     g-=1
                 else:
                     rootlist.pop(f)
                     g = f
             g += 1
    #    print("---")
        f += 1
    newt_roots = [item[0] for item in rootlist]
    return newt_roots #palauta juuret
print(Newt_roots(p1,3,5))