import socket,time
from matplotlib import pyplot as plt
import numpy as np

esp = []
parent = []
rssi = []
layer = []
posicao = []

plt.ion() #MODO INTERATIVO

fig = plt.figure()
grafico = fig.add_subplot(111,projection='polar')
grafico.set_yticklabels([])
grafico.set_xticklabels([])

while True:
	with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
		s.bind(("192.168.43.10",8000))
		# s.bind(("192.168.0.3",8000))
		s.listen()
		conn,addr = s.accept()
		with conn:
			print('Connected by',addr)
			while True:
				data = conn.recv(1024)
				dados = data.decode()
				time.sleep(0.5)
				if not data:
					break
				dados = dados.split(';')
				esp.append(dados[0])
				parent.append(dados[1])
				rssi.append(dados[2])
				layer.append(dados[3])
				posicao.append(225*(np.pi/180))
				# grafico.scatter(posicao[-1],int(layer[-1]),color='w')
				grafico.scatter(posicao[-1],int(layer[-1]),color='c')
				grp_text = grafico.annotate(rssi[-1]+'\n'+esp[-1],(posicao[-1],int(layer[-1])),fontsize=8)

				if parent[-1] in esp:
					plt.plot([posicao[-1],posicao[esp.index(parent[-1])]],[int(layer[-1]),int(layer[esp.index(parent[-1])])],color='c')
				if layer[-1]=='2':
					grafico.scatter(0,0,color='c')
					grafico.annotate(parent[-1],(0,0),fontsize=8)
					plt.plot([0,posicao[-1]],[0,int(layer[-1])],color='c')

				fig.canvas.draw_idle()#REDESENHA O GRAFICO
				plt.pause(0.1)
				grp_text.remove()
				conn.send('/n'.encode())