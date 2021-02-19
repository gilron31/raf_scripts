import numpy as np
import pickle 
import matplotlib.pyplot as plt


p_floquet = 'floquet_results'
p_nofloquet = 'nofloquet_results'
p_manyfloquet = 'alot_of_biglogs2'

f1 = open(p_floquet, 'rb')
f2 = open(p_nofloquet, 'rb')
f3 = open(p_manyfloquet, 'rb')

floquet_results = pickle.load(f1) 
nofloquet_results = pickle.load(f2) 
manyfloquet_results = pickle.load(f3) 

f1.close()
f2.close()
f3.close()

floquet_amplifications = [np.sqrt(x[1][0] ** 2 + x[1][1] ** 2) for x in floquet_results]
nofloquet_amplifications = [np.sqrt(x[1][0] ** 2 + x[1][1] ** 2) for x in nofloquet_results]
manyfloquet_amplifications = [np.sqrt(x[1][0] ** 2 + x[1][1] ** 2) for x in manyfloquet_results]

floquet_freqs = [x[0][0] for x in floquet_results]
nofloquet_freqs = [x[0][0] for x in nofloquet_results]
manyfloquet_freqs = [x[0][0] for x in manyfloquet_results]


#plt.figure()
#plt.loglog(floquet_freqs, floquet_amplifications,'x')
#plt.figure()
#plt.loglog(nofloquet_freqs, nofloquet_amplifications,'x')
#plt.title('no floquet sensitivity')
#plt.figure()
#plt.loglog(manyfloquet_freqs, manyfloquet_amplifications,'x')
#plt.title('with floquet sensitivity')
plt.figure()
plt.loglog(manyfloquet_freqs, np.array(manyfloquet_amplifications)/(2e5),'x')
plt.loglog(nofloquet_freqs, nofloquet_amplifications/nofloquet_amplifications[0],'x')
plt.title('with floquet sensitivity')

plt.show()
