using Symbolics
@variables x
q = 3*x^3-2
qsub = substitute(q, x =>complex(1,2))
qsub = complex(real(qsub).val, imag(qsub).val)
sqrt(qsub)