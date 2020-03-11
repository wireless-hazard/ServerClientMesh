import socket,time
from matplotlib import pyplot as plt
import numpy as np

esp = []
parent = []
rssi = []
layer = []
posicao = []
grp_text = []
root = '00:00:01:00:00:00'

plt.ion() #MODO INTERATIVO

fig = plt.figure()
grafico = fig.add_subplot(111,projection='polar')
grafico.set_yticklabels([])
grafico.set_xticklabels([])

while True:
	with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
		s.bind(("192.168.0.6",8000))
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
				if dados[0] in esp:
					if (dados[1] == parent[esp.index(dados[0])]):
						rssi[esp.index(dados[0])] = dados[2]
						grp_text[esp.index(dados[0])].remove()
						text = grafico.annotate(rssi[esp.index(dados[0])]+'\n'+esp[esp.index(dados[0])],(posicao[esp.index(dados[0])],int(layer[esp.index(dados[0])])),fontsize=8)
						grp_text[esp.index(dados[0])] = text
					else:
						grafico.clear()
						grafico.set_yticklabels([])
						grafico.set_xticklabels([])

						parent[esp.index(dados[0])] = dados[1]
						rssi[esp.index(dados[0])] = dados[2]
						layer[esp.index(dados[0])] = dados[3]

						posicao.append(float(dados[2])*int(dados[3])*(np.pi/180))

						for plotar in range(0,len(esp)):
							grafico.scatter(posicao[plotar],int(layer[plotar]),color='r')
							text = grafico.annotate(rssi[plotar]+'\n'+esp[plotar],(posicao[plotar],int(layer[plotar])),fontsize=8)
							grp_text[plotar] = text	

							if parent[plotar] in esp:
								plt.plot([posicao[plotar],posicao[esp.index(parent[plotar])]],[int(layer[plotar]),int(layer[esp.index(parent[plotar])])],color='c')
							if layer[plotar]=='2':
								grafico.scatter(0,0,color='r')
								root_position.remove()
								root = parent[plotar]
								root_position = grafico.annotate(parent[plotar],(0,0),fontsize=8)
								plt.plot([0,posicao[plotar]],[0,int(layer[plotar])],color='c')
				else:
					esp.append(dados[0])
					parent.append(dados[1])
					rssi.append(dados[2])
					layer.append(dados[3])
					posicao.append(float(dados[2])*int(layer[-1])*(np.pi/180))
					grafico.scatter(posicao[-1],int(layer[-1]),color='r')
					text = grafico.annotate(rssi[-1]+'\n'+esp[-1],(posicao[-1],int(layer[-1])),fontsize=8)
					grp_text.append(text)

					if parent[-1] in esp:
						plt.plot([posicao[-1],posicao[esp.index(parent[-1])]],[int(layer[-1]),int(layer[esp.index(parent[-1])])],color='c')
					if layer[-1]=='2':
						if root !=parent[-1]:

							esp = []
							parent = []
							rssi = []	
							layer = []
							posicao = []
							grp_text = []

							grafico.clear()
							grafico.set_yticklabels([])
							grafico.set_xticklabels([])

							esp.append(dados[0])
							parent.append(dados[1])
							rssi.append(dados[2])
							layer.append(dados[3])
							posicao.append(float(dados[2])*int(layer[-1])*(np.pi/180))
							grafico.scatter(posicao[-1],int(layer[-1]),color='r')
							text = grafico.annotate(rssi[-1]+'\n'+esp[-1],(posicao[-1],int(layer[-1])),fontsize=8)
							grp_text.append(text)

						grafico.scatter(0,0,color='r')
						root_position = grafico.annotate(parent[-1],(0,0),fontsize=8)
						plt.plot([0,posicao[-1]],[0,int(layer[-1])],color='c')	
				fig.canvas.draw_idle()#REDESENHA O GRAFICO
				plt.pause(0.1)
				conn.send('/n'.encode())