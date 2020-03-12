import os 
import numpy as np
from matplotlib import pyplot as plt

P0_1 = -52 #Potencia a 1 metro de distancia do transmissor 1(dBm)
P0_2 = -25 #Roteador redeESP
P0_3 = -52

n_1 = 2.2
n_2 = 2.2
n_3 = 2.2

ap1 = [0,-2.3]
bssid1 = '80:7d:3a:b7:c8:19'

ap2 = [-1,0]
bssid2 = 'c8:3a:35:0a:9d:68'

ap3 = [0,0.7]
bssid3 = 'a4:cf:12:75:21:31' 

#plt.ion() #MODO INTERATIVO

x = np.arange(-2,3,0.2)

while True:
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

    x= np.arange(-4,5)

    theta = np.linspace(0,2*np.pi,360)

    x1 = d1_chapeu*np.cos(theta)+ap1[0]
    y1 = d1_chapeu*np.sin(theta)+ap1[1]
    grafico.scatter(ap1[0],ap1[1],c='r')
    grafico.plot(x1,y1,c='b')

    x2 = d2_chapeu*np.cos(theta)+ap2[0]
    y2 = d2_chapeu*np.sin(theta)+ap2[1]
    grafico.scatter(ap2[0],ap2[1],c='r')
    grafico.plot(x2,y2,c='b')

    x3 = d3_chapeu*np.cos(theta)+ap3[0]
    y3 = d3_chapeu*np.sin(theta)+ap3[1]
    grafico.scatter(ap3[0],ap3[1],c='r')
    grafico.plot(x3,y3,c='b')

    
    reta1 = ((d1_chapeu**2 - d2_chapeu**2 + (ap2[0])**2 - (ap1[0])**2 + (ap2[1])**2 - ap1[1]**2)/2 - (ap2[0]-ap1[0])*x)/(ap2[1]-ap1[1])
    grafico.plot(x,reta1,c='c')

    reta2 = ((d1_chapeu**2 - d3_chapeu**2 + (ap3[0])**2 - (ap1[0])**2 + (ap3[1])**2 - ap1[1]**2)/2 - (ap3[0]-ap1[0])*x)/(ap3[1]-ap1[1])
    grafico.plot(x,reta2,c='c')

    reta3 = ((d2_chapeu**2 - d3_chapeu**2 + (ap3[0])**2 - (ap2[0])**2 + (ap3[1])**2 - ap2[1]**2)/2 - (ap3[0]-ap2[0])*x)/(ap3[1]-ap2[1]) 
    grafico.plot(x,reta3,c='c')

    x_intersec = ((x[0]*reta1[-1]-reta1[0]*x[-1])*(x[0]-x[-1])-(x[0]-x[-1])*(x[0]*reta2[-1]-reta2[0]*x[-1]))/((x[0]-x[-1])*(reta2[0]-reta2[-1])-(reta1[0]-reta1[-1])*(x[0]-x[-1]))
    y_intersec = ((x[0]*reta1[-1]-reta1[0]*x[-1])*(reta2[0]-reta2[-1])-(reta1[0]-reta1[-1])*(x[0]*reta2[-1]-reta2[0]*x[-1]))/((x[0]-x[-1])*(reta2[0]-reta2[-1])-(reta1[0]-reta1[-1])*(x[0]-x[-1]))
    grafico.scatter(x_intersec,y_intersec,c='k')
    print(x_intersec,y_intersec)

    plt.show()