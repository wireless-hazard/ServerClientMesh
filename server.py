import socket,time
from matplotlib import pyplot as plt
import numpy as np

esp = []
parent = []
rssi = []
layer = []
posicao = []
grp_text = []

plt.ion() #MODO INTERATIVO

fig = plt.figure()
grafico = fig.add_subplot(111,projection='polar')
grafico.set_yticklabels([])
grafico.set_xticklabels([])

while True:
	with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
		# s.bind(("192.168.43.10",8000))
		s.bind(("192.168.0.3",8000))
		s.listen()
		conn,addr = s.accept()
		with conn:
			print('Connected by',addr)
			while True:
				data = conn.recv(1024)
				dados = data.decode()
				# time.sleep(0.5)
				if not data:
					break
				dados = dados.split(';')
				if dados[0] in esp:
					if dados[1] in parent:
						rssi[parent.index(dados[1])] = dados[2]
						grp_text[parent.index(dados[1])].remove()
						text = grafico.annotate(rssi[parent.index(dados[1])]+'\n'+esp[parent.index(dados[1])],(posicao[parent.index(dados[1])],int(layer[parent.index(dados[1])])),fontsize=8)
						grp_text[parent.index(dados[1])] = text
				else:
					esp.append(dados[0])
					parent.append(dados[1])
					rssi.append(dados[2])
					layer.append(dados[3])
					posicao.append(float(dados[2])*int(layer[-1])*(np.pi/180))
					grafico.scatter(posicao[-1],int(layer[-1]),color='c')
					text = grafico.annotate(rssi[-1]+'\n'+esp[-1],(posicao[-1],int(layer[-1])),fontsize=8)
					grp_text.append(text)

					if parent[-1] in esp:
						plt.plot([posicao[-1],posicao[esp.index(parent[-1])]],[int(layer[-1]),int(layer[esp.index(parent[-1])])],color='c')
					if layer[-1]=='2':
						grafico.scatter(0,0,color='c')
						grafico.annotate(parent[-1],(0,0),fontsize=8)
						plt.plot([0,posicao[-1]],[0,int(layer[-1])],color='c')

				fig.canvas.draw_idle()#REDESENHA O GRAFICO
				plt.pause(0.1)
				conn.send('/n'.encode())