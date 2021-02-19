import numpy as np
import pickle 
import matplotlib.pyplot as plt


p_floquet = 'floquet_results'
p_nofloquet = 'nofloquet_results'

f1 = open(p_floquet, 'rb')
f2 = open(p_nofloquet, 'rb')

floquet_results = pickle.load(f1) 
nofloquet_results = pickle.load(f2) 

f1.close()
f2.close()

floquet_amplifications = [np.sqrt(x[1][0] ** 2 + x[1][1] ** 2) for x in floquet_results]
nofloquet_amplifications = [np.sqrt(x[1][0] ** 2 + x[1][1] ** 2) for x in nofloquet_results]

floquet_freqs = [x[0][0] for x in floquet_results]
nofloquet_freqs = [x[0][0] for x in nofloquet_results]


plt.figure()
plt.loglog(floquet_freqs, floquet_amplifications,'x')
plt.figure()
plt.loglog(nofloquet_freqs, nofloquet_amplifications,'x')

plt.show()
