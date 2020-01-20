import socket,time,sys
from datetime import datetime
def acesso(autorizado):
	with open('log_acesso.txt','a') as obj:
		obj.write(';'.join([str(autorizado),str(datetime.now()),'\n']))
def recusado(usuario):
	with open('log_tentativa_nao_autorizada.txt','a') as obj:
		obj.write(';'.join([str(usuario),str(datetime.now()),'\n']))	
acesso_permitido = ['9B,13,24,1B','61,3F,4F,D3']
while True:
	with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
		s.bind(("192.168.43.10",8000))
		s.listen()
		conn,addr = s.accept()
		with conn:
			print('Connected by',addr)
			while True:
				data = conn.recv(1024)
				print(data.decode())
				time.sleep(0.5)
				if not data:
					break
				conn.send('/n'.encode())
