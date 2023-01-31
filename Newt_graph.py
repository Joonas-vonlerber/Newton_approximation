from sympy.plotting.plot import MatplotlibBackend, Plot
from sympy.plotting import plot
from Newt_roots import Newt_roots
import matplotlib.pyplot as plt
from sympy import re, im, Symbol

x = Symbol('x')
p1 = x**6 -3/2*x**5 -1/2*x**4- x**3 +12
def Newt_graph(expr):
    
#    def get_sympy_subplots(plot: Plot): #mustaa magiaa
#        backend = MatplotlibBackend(plot)#ei mitään hajua
#
#        backend.process_series() #hauskoja juttuja
#        backend.fig.tight_layout() #kyllä 
#        return backend.fig, backend.ax[0]#ihan ok, mutta ootko nähnyt simpsonit sarjasta jakson himoläski homer :D

    coords = Newt_roots(expr, 3, 5)
    xcoords=[]
    ycoords=[]
    xrealc=[]
    yrealc=[]
    right = 0
    left = 0
    for i in coords:
        xcoords.append(re(i))
        ycoords.append(im(i))
        if im(i) == 0:
            xrealc.append(i)
            yrealc.append(0)
            if i <= left:
                left = i
            elif i>= right:
                right = i
        
    #p = plot(expr, (x,left-0.5,right+0.5), show=False) #piirretään funktio
    #fig, axe = get_sympy_subplots(p) #siinä esiintyy koko simpsonit perhe eli myös bart simpsons homer poika fanit saavat nauraa        
    #axe.plot(xrealc,yrealc, 'o') #pistetään siihen ne pisteet


    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.spines['left'].set_position('zero')
    ax.spines['bottom'].set_position('zero')
    ax.spines['right'].set_color('none')
    ax.spines['top'].set_color('none')
    ax.xaxis.set_ticks_position('bottom')
    ax.yaxis.set_ticks_position('left')
    ax.set_ylabel('Im')
    ax.set_xlabel('Re')
    plt.plot(xcoords,ycoords, 'o', )

    # show the plot
    plt.show()
    print(coords)
    return
#Newt_graph(p1)