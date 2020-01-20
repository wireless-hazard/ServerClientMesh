import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0',8000))
s.listen(0)

while True:
    clientsocket, address = s.accept()
    with clientsocket:
        print('Connected by',address)
        while True:
            data = clientsocket.recv(1024)
            print(data.decode())