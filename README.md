# Newt_approximation

A project made in 9th grade programming class where I implemented the Newton–Raphson method and expanded the algorithm by trying to find every root by applying the Newton approximation on a grid of lattice points near the origin.

## The algorithm

The algorithm for approximating the continious function $f(x)$ is as follows

  1. Get an initial guess of the root and set it as $x_0$. The guess doesn't have to be exact but shouldn't be too far away.
  2. Use the Newton-Raphson equation
       $$x_n = x_{n-1} - \frac{f(x_{n-1})}{f'(x_{n-1})}$$
  3. repeat step 2 until a sufficient approximation has been reached.

Generally the convergence of the algorithm is quadratic but it is to be noted that some initial conditions must be met for this to be always true. Quadratic convergence means that the accuracy of the algorithm on the next iteration is squared
that of the previous iteration which basically means the number of correct digits roughly doubles at each iteration. In mathematical notation $|x_{\text{root}}-x_{n+1}|\approx |x_{\text{root}} - x_n|^2$. Proof of this and the initial conditions can be found on [wikipedia](https://en.wikipedia.org/wiki/Newton%27s_method#Proof_of_quadratic_convergence_for_Newton's_iterative_method).

![newt_approx geometrically](https://upload.wikimedia.org/wikipedia/commons/e/e0/NewtonIteration_Ani.gif)

## The problems and the conditions of the algorithm

There are some problems with the algorithm which might hinder the convergence of the algorithm or might even stop it from running altogether. List of them can be found on [wikipedia](https://en.wikipedia.org/wiki/Newton%27s_method#Practical_considerations)

## My expansion of the algorithm

I expanded the algorithm by making it find every complex root near the origin of the complex plain for the continiuous function $f(x),\ f:\mathbb{C}\rightarrow\mathbb{C}$. 

### The gist of the algorithm

  1. Place points on the complex grid making a square with upper left corner in $(-n,n)$ and down right corner $(n,-n)$ where $n\in\mathbb{N}.
  2. Apply Newton-Raphson approximation algorithm on each of them and make a list of them.
  3. filter out duplicates and unaccurate approximations
  4. return the remaining list

## Differentiation

On pyhton I used the symbolic derivative, which I calculated with the [sympy library](https://www.sympy.org/en/index.html).
On Julia I first started out using [symbolics.js](https://symbolics.juliasymbolics.org/stable/) but after a while I wanted to play around with dual numbers $\mathbb{R}(\epsilon)$ which are similar to the complex numbers but $\epsilon^2=0, \epsilon \neq 0$. They have a peculiar property that for every (analytic) real function can be expanded into the dual numbers $f(a+b\epsilon) = f(a) + b\cdot f'(a)$. Dual numbers give very good approximations of derivatives and can be calculated easly.
