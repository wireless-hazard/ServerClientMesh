#include <string.h>
#include "esp_system.h"
#include "esp_log.h"
#include "nvs_flash.h"
#include "esp_wifi.h"
#include "esp_event_loop.h"
#include "esp_mesh.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "lwip/sockets.h"

#define IPDELE "192.168.137.55"
#define ROUTER "192.168.43.1"
#define MASCARADELE "255.255.255.0"
#define CAMADAS 3
#define CANAL_WIFI 0
#define ROUTER_SSID "apteste"
#define ROUTER_PSWD "magnomaia"
#define AUTH_MODE WIFI_AUTH_WPA_WPA2_PSK
#define MAX_CLIENTS 5
#define TX_SIZE (1460)
#define TODS_IP "192.168.43.10"
#define TODS_PORT 8000

static const uint8_t MESH_ID[6] = {0x05, 0x02, 0x96, 0x05, 0x02, 0x96};
static const char *MESH_TAG = "mesh_tagger";
static bool is_mesh_connected = false;
static int mesh_layer = -1;
static mesh_addr_t mesh_parent_addr;
static uint8_t tx_buffer[TX_SIZE] = { 0, };
static uint8_t rx_buffer[MESH_MTU] = { 0, };

static mesh_addr_t adm;
static mesh_data_t current_status;
static int bandeira;
static ip4_addr_t ipteste[4] = {0,};

void waytogate(){
	
	// adm.mip.ip4.addr = ipaddr_addr("192.168.137.1");
	// adm.mip.port = 8000;
	// memcpy(tx_buffer,(uint8_t *)&mesh_layer,sizeof(mesh_layer));

	while(true){
		
		adm.mip.ip4.addr = ipaddr_addr(TODS_IP);
		adm.mip.port = TODS_PORT;
		// memcpy(tx_buffer,(uint8_t *)&mesh_layer,sizeof(mesh_layer));

		// memcpy(adm.addr, mesh_parent_addr.addr, 6);
		current_status.data = tx_buffer;
		current_status.size = sizeof(tx_buffer);
		current_status.proto = MESH_PROTO_BIN;
		// bandeira = MESH_DATA_P2P;
		bandeira = MESH_DATA_TODS;
		wifi_ap_record_t apdata;

		esp_err_t err = esp_wifi_sta_get_ap_info(&apdata);
		if (err == ESP_OK){
			ESP_LOGW(MESH_TAG,"rssi: %d\n",apdata.rssi);
		}
		memcpy(current_status.data,(uint8_t *)&apdata.rssi,sizeof(apdata.rssi));
		ESP_ERROR_CHECK(esp_mesh_send(&adm,&current_status,bandeira,NULL,0));
		ESP_LOGW(MESH_TAG,"Enviando camada para o router");
		vTaskDelay(5*1000/portTICK_PERIOD_MS);
		
	}
	vTaskDelete(NULL);
}

void mesh_p2p_rx(void *pvParameters){

	mesh_addr_t from;
	mesh_addr_t to;
	mesh_data_t data;
	data.size = MESH_MTU;
	data.data = rx_buffer;
	mesh_rx_pending_t rx_pending;
	uint8_t teste = {0,};
	
	int flag = 0;

	while(true){
		ESP_ERROR_CHECK(esp_mesh_get_rx_pending(&rx_pending));
		ESP_LOGI(MESH_TAG,"%d %d",rx_pending.toSelf,rx_pending.toDS);

		data.size = MESH_MTU;
		
		if (rx_pending.toSelf>0){
			esp_err_t err = esp_mesh_recv(&from,&data,0,&flag,NULL,0); //portMAX_DELAY
			// memcpy(teste,&data.data,sizeof(data.data));
			uint8_t *p = data.data;

			ESP_LOGE(MESH_TAG, "vindos de: "MACSTR" dados: %d, size: %d",MAC2STR(from.addr),  (int8_t)*p, data.size);
		}
		if(rx_pending.toDS>0){

			esp_err_t err = esp_mesh_recv_toDS(&from,&to,&data,0,&flag,NULL,0);
			uint8_t *p = data.data;

			ESP_LOGE(MESH_TAG, "vindos de: "MACSTR" dados: %d, size: %d",MAC2STR(from.addr),  (int8_t)*p, data.size);
			ESP_LOGE(MESH_TAG,"Passando os pacotes via SOCKETS para o ip "IPSTR"",IP2STR(&to.mip.ip4));

			memcpy(ipteste,&to.mip.ip4.addr,sizeof(to.mip.ip4.addr));
			
			char rx_buffer[128];
    		char addr_str[128];
    		int addr_family;
    		int ip_protocol;
    		
			struct sockaddr_in destAddr;

			int Byte1 = ((int)ip4_addr1(ipteste));
    		int Byte2 = ((int)ip4_addr2(ipteste));
    		int Byte3 = ((int)ip4_addr3(ipteste));
    		int Byte4 = ((int)ip4_addr4(ipteste));

    		char ip_final[19]={0,};
    		char dados_final[data.size];
    		
    		printf("%d\n", (int8_t)*p);
    		sprintf(ip_final,"%d.%d.%d.%d",Byte1,Byte2,Byte3,Byte4);
    		printf("%d\n %d",sizeof(dados_final),sizeof(data.data));

    		sprintf(dados_final,"%d",(int8_t)*p);

    		destAddr.sin_addr.s_addr = inet_addr(ip_final);
    		destAddr.sin_family = AF_INET;
    		destAddr.sin_port = htons((unsigned short)to.mip.port);
    		addr_family = AF_INET;
    		ip_protocol = IPPROTO_IP;
    		inet_ntoa_r(destAddr.sin_addr, addr_str, sizeof(addr_str) - 1);
	
			int sock =  socket(addr_family, SOCK_STREAM, ip_protocol);
	
			int error = connect(sock, (struct sockaddr *)&destAddr, sizeof(destAddr));
			printf("Estado da conexao: %d\n",error);
			// send(sock,&data,strlen(&data), 0);

			send(sock,&dados_final,strlen(&dados_final),0);
			
			close(sock);

			
		}
		vTaskDelay(1000/portTICK_PERIOD_MS);
	}
}

void mesh_event_handler(mesh_event_t evento){
	switch (evento.id){
	static int filhos = 0;
	static uint8_t last_layer = 0;
	//
	//MESH MAIN SETUP EVENTS
	//
	case MESH_EVENT_STARTED: //start sending Wifi beacon frames and begin scanning for preferred parent.	
		is_mesh_connected = false;
		mesh_layer = esp_mesh_get_layer();
		ESP_LOGW(MESH_TAG,"MESH STARTED\n");

	break;
	case MESH_EVENT_STOPPED: //Reset the mesh stack's status on the device
		is_mesh_connected = false;
        mesh_layer = esp_mesh_get_layer();
		ESP_LOGE(MESH_TAG,"ALGO GRAVE ACONTECEU\n");
	break;
	case MESH_EVENT_PARENT_CONNECTED:
		//COPY AND PAST'ED 
		mesh_layer = evento.info.connected.self_layer;
		memcpy(&mesh_parent_addr.addr, evento.info.connected.connected.bssid, 6);
		last_layer = mesh_layer;
        is_mesh_connected = true;
		if (esp_mesh_is_root()) {
            tcpip_adapter_dhcpc_start(TCPIP_ADAPTER_IF_STA);
        }
        else{
        	xTaskCreatePinnedToCore(&waytogate,"Transmissao",4096,NULL,5,NULL,0);
    	}
		printf("Nao esta finalizado\n");
	break;
	case MESH_EVENT_PARENT_DISCONNECTED: //Perform a fixed number of attempts to reconnect before searching for another one
		is_mesh_connected = false;
        mesh_layer = esp_mesh_get_layer();
		ESP_LOGW(MESH_TAG,"Pai desconectou\n");
	break;
	case MESH_EVENT_NO_PARENT_FOUND:
		ESP_LOGW(MESH_TAG,"eternamente IDLE\n");
	break;
	//
	//MESH NETWORK UPDATE EVENTS
	//
	case MESH_EVENT_CHILD_CONNECTED: //A child node sucessfully connects  to the  node's  SoftAP interface
		filhos = filhos + 1;
		ESP_LOGW(MESH_TAG,"Mais um filho conectado %d\n",filhos);
	break;
	case MESH_EVENT_CHILD_DISCONNECTED: //A child node disconnects from  a node 
		filhos = filhos - 1;
		printf(MAC2STR(evento.info.child_disconnected.mac));
	break;
	case MESH_EVENT_ROUTING_TABLE_ADD: //A node's descendant (with its possible futher descendants) joins the mesh network
		ESP_LOGW(MESH_TAG,"MAC adicionado a tabela de roteamento\n");
	break;
	case MESH_EVENT_ROUTING_TABLE_REMOVE: //A node's descendant (with its possible futher descendants) desconnects from the mesh network
		ESP_LOGW(MESH_TAG,"MAC removido da tabela de roteamento\n");
	break;
	case MESH_EVENT_ROOT_ADDRESS: //Propagacao do MAC do noh raiz da rede Mesh
		ESP_LOGW(MESH_TAG,"MESH_EVENT_ROOT_ADDRESS\n");		
	break;
	case MESH_EVENT_ROOT_FIXED: //Quando a configuracao de root fixo difere entre dois nohs tentando comunicar
		ESP_LOGW(MESH_TAG,"MESH_EVENT_ROOT_FIXED ISSO NAO PODE ACONTECER\n");
	break;
	case MESH_EVENT_TODS_STATE: //The node is informed of a change in the accessibility of the external DS
		ESP_LOGW(MESH_TAG,"MESH_EVENT_TODS_STATE\n");
	break;
	case MESH_EVENT_VOTE_STARTED: //A new rote election is started in the mesh network
		ESP_LOGW(MESH_TAG,"Votacao comecou\n");
	break;
	case MESH_EVENT_VOTE_STOPPED: //The election has ended
		ESP_LOGW(MESH_TAG,"Eleicao acabou\n");
	break;
	case MESH_EVENT_LAYER_CHANGE: //The node's layer in the mesh network has changed
		ESP_LOGE(MESH_TAG,"Mudou de Layer\n");
		mesh_layer = evento.info.layer_change.new_layer;
		last_layer = mesh_layer;
	break;
	case MESH_EVENT_CHANNEL_SWITCH: //The mesh wifi channel has changed
		ESP_LOGE(MESH_TAG,"Mudou para o canal %d\n",evento.info.channel_switch.channel);
	break;
	//
	//MESH ROOT-SPECIFIC EVENTS
	//
	case MESH_EVENT_ROOT_GOT_IP: //The station DHCP client retrieves a dynamic IP configuration or a Static IP is applied
		ESP_LOGW(MESH_TAG,"MESH_EVENT_ROOT_GOT_IP\n");
		 ESP_LOGI(MESH_TAG,
                 "<MESH_EVENT_ROOT_GOT_IP>sta ip: " IPSTR ", mask: " IPSTR ", gw: " IPSTR,
                 IP2STR(&evento.info.got_ip.ip_info.ip),
                 IP2STR(&evento.info.got_ip.ip_info.netmask),
                 IP2STR(&evento.info.got_ip.ip_info.gw));
		// xTaskCreatePinnedToCore(&idf_socket,"Comunicacao",4096,NULL,5,NULL,0);
		xTaskCreatePinnedToCore(&mesh_p2p_rx,"Recepcao",4096,NULL,5,NULL,1);
	break;
	case MESH_EVENT_ROOT_LOST_IP: //The lease time  of the Node's station dynamic IP configuration has expired
		ESP_LOGE(MESH_TAG,"Root perdeu IP\n");
	break;
	case MESH_EVENT_ROOT_SWITCH_REQ: //The root node has received a root switch request from  a candidate root
		ESP_LOGE(MESH_TAG,"Tao querendo troca de root\n");
		printf(MAC2STR( evento.info.switch_req.rc_addr.addr));
	break;
	case MESH_EVENT_ROOT_ASKED_YIELD: //Another root node with a higher RSSI with the router has asked this root node to yield
		printf("//TODO \n");
	break;
	default:
	break;
	}
}

void rotinaMesh(){
	
	ESP_ERROR_CHECK(esp_mesh_init()); //Inicializa o "mesh stack"
	ESP_ERROR_CHECK(esp_mesh_set_max_layer(CAMADAS));//Numero maximo de niveis da rede
	ESP_ERROR_CHECK(esp_mesh_set_vote_percentage(0.9));//Porcentagem minima para a escolha do Noh raiz
    ESP_ERROR_CHECK(esp_mesh_set_ap_assoc_expire(40));//Tempo sem comunicacao entre pai e filho com que fara a dissociacao do filho
	
	mesh_cfg_t config_mesh = MESH_INIT_CONFIG_DEFAULT(); //Possui a configuracao base mesh para aplicar depois
	
	//Mesh Network Identifier (MID)
	memcpy((uint8_t *) &config_mesh.mesh_id,MESH_ID,6);
	
	config_mesh.event_cb = &mesh_event_handler; //mesh event callback
	config_mesh.channel = CANAL_WIFI;
	config_mesh.router.ssid_len = strlen(ROUTER_SSID);
	memcpy((uint8_t *) &config_mesh.router.ssid, ROUTER_SSID, config_mesh.router.ssid_len);
    memcpy((uint8_t *) &config_mesh.router.password, ROUTER_PSWD, strlen(ROUTER_PSWD));
	config_mesh.mesh_ap.max_connection = MAX_CLIENTS;
    memcpy((uint8_t *) &config_mesh.mesh_ap.password, ROUTER_PSWD, strlen(ROUTER_PSWD));
    ESP_ERROR_CHECK(esp_mesh_set_config(&config_mesh));
    /* mesh start */
    ESP_ERROR_CHECK(esp_mesh_start());
	//esp_mesh_set_self_organized() nao usado pois self organized eh setado por default
}

void rotinaWifi(){
	
	//s_wifi_event_group = xEventGroupCreate();//TALVEZ NAO SEJA ESSE //PELO JEITO NAO EH MESMO RSRSRSRS
	
	tcpip_adapter_init(); //Inicializa as estruturas de dados TCP/LwIP e cria a tarefa principal LwIP
	//atribuicao de ip estatico
	tcpip_adapter_ip_info_t ip_estatico;
	ip_estatico.ip.addr = ipaddr_addr(IPDELE);//Atribui ip estatico
	ip_estatico.gw.addr = ipaddr_addr(ROUTER);//Atribui o ip do gateway
	ip_estatico.netmask.addr = ipaddr_addr(MASCARADELE);//Atribui a mascara de rede
	tcpip_adapter_set_ip_info(WIFI_IF_STA,&ip_estatico);
	
	
	ESP_ERROR_CHECK(esp_event_loop_init(NULL,NULL)); //Lida com os eventos AINDA NAO IMPLEMENTADOS
	
	wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT(); //
	esp_wifi_init(&cfg); //Inicia o Wifi com os seus parametros padroes
	
	ESP_ERROR_CHECK(tcpip_adapter_dhcpc_stop(TCPIP_ADAPTER_IF_STA));//Desliga o cliente dhcp
	ESP_ERROR_CHECK(tcpip_adapter_dhcps_stop(TCPIP_ADAPTER_IF_AP));//Desliga o servidor dhcp
	
	ESP_ERROR_CHECK(esp_wifi_start());
	rotinaMesh();
}

void app_main(void){
	//Initialize NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
      ESP_ERROR_CHECK(nvs_flash_erase());
      ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK(ret);
	
	rotinaWifi();
}