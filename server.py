import socket,time

while True:
	with socket.socket(socket.AF_INET,socket.SOCK_STREAM) as s:
		s.bind(("192.168.43.10",8000))
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
				print(dados[2])
				conn.send('/n'.encode())
