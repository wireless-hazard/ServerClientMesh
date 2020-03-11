import os 
import numpy as np
from matplotlib import pyplot as plt

P0_1 = -52 #Potencia a 1 metro de distancia do transmissor 1(dBm)
P0_2 = -35
P0_3 = -43

n_1 = 5
n_2 = 5
n_3 = 5

ap1 = [-0.7,0.5]
bssid1 = '80:7d:3a:b7:c8:19'

ap2 = [-0.8,0.3]
bssid2 = 'c8:3a:35:0a:9d:68'

ap3 = [0,-0.2]
bssid3 = 'a4:cf:12:75:21:31' 

#plt.ion() #MODO INTERATIVO

fig = plt.figure()
grafico = fig.add_subplot(111,projection='rectilinear')

stream = os.popen('sudo iw dev wlp1s0 scan')
output = stream.readlines()

for cell_index in range(0,len(output)):
    if bssid1 in output[cell_index]:
        print(output[cell_index][4:21]+'\n')
        Pij_1 = int(output[cell_index+5][8:12])
        print(Pij_1)
    if bssid2 in output[cell_index]:
        print(output[cell_index][4:21]+'\n')
        Pij_2 = int(output[cell_index+5][8:12])
        print(Pij_2)
    if bssid3 in output[cell_index]:
    	print(output[cell_index][4:21]+'\n')
    	Pij_3 = int(output[cell_index+5][8:12])
    	print(Pij_3)


d1_chapeu = (10**((P0_1-Pij_1)/(10*n_1)))
d2_chapeu = (10**((P0_2-Pij_2)/(10*n_2)))
d3_chapeu = (10**((P0_3-Pij_3)/(10*n_3)))

theta = np.linspace(0,2*np.pi,360)

x = d1_chapeu*np.cos(theta)+ap1[0]
y = d1_chapeu*np.sin(theta)+ap1[1]
grafico.scatter(ap1[0],ap1[1],c='r')
grafico.plot(x,y,c='b')

x = d2_chapeu*np.cos(theta)+ap2[0]
y = d2_chapeu*np.sin(theta)+ap2[1]
grafico.scatter(ap2[0],ap2[1],c='r')
grafico.plot(x,y,c='b')

x = d3_chapeu*np.cos(theta)+ap3[0]
y = d3_chapeu*np.sin(theta)+ap3[1]
grafico.scatter(ap3[0],ap3[1],c='r')
grafico.plot(x,y,c='b')

plt.show()