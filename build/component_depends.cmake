# Component requirements generated by expand_requirements.cmake

set(BUILD_COMPONENTS soc;log;heap;xtensa-debug-module;app_trace;freertos;vfs;newlib;esp_ringbuf;driver;esp_event;ethernet;mbedtls;micro-ecc;efuse;bootloader_support;partition_table;app_update;spi_flash;nvs_flash;lwip;tcpip_adapter;pthread;smartconfig_ack;wpa_supplicant;espcoredump;esp32;cxx;asio;jsmn;aws_iot;bootloader;nimble;bt;coap;console;nghttp;esp-tls;esp_adc_cal;tcp_transport;esp_http_client;esp_http_server;esp_https_ota;openssl;esp_https_server;esptool_py;expat;wear_levelling;sdmmc;fatfs;freemodbus;idf_test;json;libsodium;mdns;mqtt;protobuf-c;protocomm;spiffs;ulp;unity;wifi_provisioning;main)
set(BUILD_COMPONENT_PATHS /home/magno/esp-idf/components/soc;/home/magno/esp-idf/components/log;/home/magno/esp-idf/components/heap;/home/magno/esp-idf/components/xtensa-debug-module;/home/magno/esp-idf/components/app_trace;/home/magno/esp-idf/components/freertos;/home/magno/esp-idf/components/vfs;/home/magno/esp-idf/components/newlib;/home/magno/esp-idf/components/esp_ringbuf;/home/magno/esp-idf/components/driver;/home/magno/esp-idf/components/esp_event;/home/magno/esp-idf/components/ethernet;/home/magno/esp-idf/components/mbedtls;/home/magno/esp-idf/components/micro-ecc;/home/magno/esp-idf/components/efuse;/home/magno/esp-idf/components/bootloader_support;/home/magno/esp-idf/components/partition_table;/home/magno/esp-idf/components/app_update;/home/magno/esp-idf/components/spi_flash;/home/magno/esp-idf/components/nvs_flash;/home/magno/esp-idf/components/lwip;/home/magno/esp-idf/components/tcpip_adapter;/home/magno/esp-idf/components/pthread;/home/magno/esp-idf/components/smartconfig_ack;/home/magno/esp-idf/components/wpa_supplicant;/home/magno/esp-idf/components/espcoredump;/home/magno/esp-idf/components/esp32;/home/magno/esp-idf/components/cxx;/home/magno/esp-idf/components/asio;/home/magno/esp-idf/components/jsmn;/home/magno/esp-idf/components/aws_iot;/home/magno/esp-idf/components/bootloader;/home/magno/esp-idf/components/nimble;/home/magno/esp-idf/components/bt;/home/magno/esp-idf/components/coap;/home/magno/esp-idf/components/console;/home/magno/esp-idf/components/nghttp;/home/magno/esp-idf/components/esp-tls;/home/magno/esp-idf/components/esp_adc_cal;/home/magno/esp-idf/components/tcp_transport;/home/magno/esp-idf/components/esp_http_client;/home/magno/esp-idf/components/esp_http_server;/home/magno/esp-idf/components/esp_https_ota;/home/magno/esp-idf/components/openssl;/home/magno/esp-idf/components/esp_https_server;/home/magno/esp-idf/components/esptool_py;/home/magno/esp-idf/components/expat;/home/magno/esp-idf/components/wear_levelling;/home/magno/esp-idf/components/sdmmc;/home/magno/esp-idf/components/fatfs;/home/magno/esp-idf/components/freemodbus;/home/magno/esp-idf/components/idf_test;/home/magno/esp-idf/components/json;/home/magno/esp-idf/components/libsodium;/home/magno/esp-idf/components/mdns;/home/magno/esp-idf/components/mqtt;/home/magno/esp-idf/components/protobuf-c;/home/magno/esp-idf/components/protocomm;/home/magno/esp-idf/components/spiffs;/home/magno/esp-idf/components/ulp;/home/magno/esp-idf/components/unity;/home/magno/esp-idf/components/wifi_provisioning;/home/magno/Documents/Github/mesh/ServerClientMesh/main)
set(BUILD_TEST_COMPONENTS )
set(BUILD_TEST_COMPONENT_PATHS )

# get_component_requirements: Generated function to read the dependencies of a given component.
#
# Parameters:
# - component: Name of component
# - var_requires: output variable name. Set to recursively expanded COMPONENT_REQUIRES 
#   for this component.
# - var_private_requires: output variable name. Set to recursively expanded COMPONENT_PRIV_REQUIRES 
#   for this component.
#
# Throws a fatal error if 'componeont' is not found (indicates a build system problem).
#
function(get_component_requirements component var_requires var_private_requires)
  if("${component}" STREQUAL "soc")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "log")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "heap")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "xtensa-debug-module")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "app_trace")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "xtensa-debug-module" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "freertos")
    set(${var_requires} "app_trace" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "vfs")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "newlib")
    set(${var_requires} "vfs" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_ringbuf")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "driver")
    set(${var_requires} "esp_ringbuf" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_event")
    set(${var_requires} "log" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "ethernet")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "tcpip_adapter;esp_event" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "mbedtls")
    set(${var_requires} "lwip" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "micro-ecc")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "efuse")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "bootloader_support" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "bootloader_support")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "spi_flash;mbedtls;micro-ecc;efuse" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "partition_table")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "app_update")
    set(${var_requires} "spi_flash;partition_table;bootloader_support" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "spi_flash")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "bootloader_support;app_update" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "nvs_flash")
    set(${var_requires} "spi_flash;mbedtls" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "lwip")
    set(${var_requires} "vfs" PARENT_SCOPE)
    set(${var_private_requires} "ethernet;tcpip_adapter;nvs_flash" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "tcpip_adapter")
    set(${var_requires} "lwip" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "pthread")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "smartconfig_ack")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "lwip;tcpip_adapter" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "wpa_supplicant")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "mbedtls" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "espcoredump")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "spi_flash" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp32")
    set(${var_requires} "driver;tcpip_adapter;esp_event;efuse" PARENT_SCOPE)
    set(${var_private_requires} "app_trace;app_update;bootloader_support;ethernet;log;mbedtls;nvs_flash;pthread;smartconfig_ack;spi_flash;vfs;wpa_supplicant;xtensa-debug-module;espcoredump" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "cxx")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "asio")
    set(${var_requires} "lwip" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "jsmn")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "aws_iot")
    set(${var_requires} "mbedtls" PARENT_SCOPE)
    set(${var_private_requires} "jsmn" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "bootloader")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "nimble")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "bt;nvs_flash" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "bt")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "nvs_flash;nimble" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "coap")
    set(${var_requires} "lwip" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "console")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "nghttp")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp-tls")
    set(${var_requires} "mbedtls" PARENT_SCOPE)
    set(${var_private_requires} "lwip;nghttp" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_adc_cal")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "tcp_transport")
    set(${var_requires} "lwip;esp-tls" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_http_client")
    set(${var_requires} "nghttp" PARENT_SCOPE)
    set(${var_private_requires} "mbedtls;lwip;esp-tls;tcp_transport" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_http_server")
    set(${var_requires} "nghttp" PARENT_SCOPE)
    set(${var_private_requires} "lwip" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_https_ota")
    set(${var_requires} "esp_http_client" PARENT_SCOPE)
    set(${var_private_requires} "log;app_update" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "openssl")
    set(${var_requires} "mbedtls" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esp_https_server")
    set(${var_requires} "esp_http_server;openssl" PARENT_SCOPE)
    set(${var_private_requires} "lwip" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "esptool_py")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "expat")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "wear_levelling")
    set(${var_requires} "spi_flash" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "sdmmc")
    set(${var_requires} "driver" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "fatfs")
    set(${var_requires} "wear_levelling;sdmmc" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "freemodbus")
    set(${var_requires} "driver" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "idf_test")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "json")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "libsodium")
    set(${var_requires} "mbedtls" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "mdns")
    set(${var_requires} "lwip;mbedtls;console;tcpip_adapter" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "mqtt")
    set(${var_requires} "lwip;nghttp;mbedtls;tcp_transport" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "protobuf-c")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "protocomm")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "protobuf-c;mbedtls;console;esp_http_server;bt" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "spiffs")
    set(${var_requires} "spi_flash" PARENT_SCOPE)
    set(${var_private_requires} "bootloader_support" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "ulp")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "unity")
    set(${var_requires} "" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "wifi_provisioning")
    set(${var_requires} "lwip;protocomm" PARENT_SCOPE)
    set(${var_private_requires} "protobuf-c;bt;mdns;json" PARENT_SCOPE)
    return()
  endif()
  if("${component}" STREQUAL "main")
    set(${var_requires} "app_trace;app_update;asio;aws_iot;bootloader;bootloader_support;bt;coap;console;cxx;driver;efuse;esp-tls;esp32;esp_adc_cal;esp_event;esp_http_client;esp_http_server;esp_https_ota;esp_https_server;esp_ringbuf;espcoredump;esptool_py;ethernet;expat;fatfs;freemodbus;freertos;heap;idf_test;jsmn;json;libsodium;log;lwip;mbedtls;mdns;micro-ecc;mqtt;newlib;nghttp;nimble;nvs_flash;openssl;partition_table;protobuf-c;protocomm;pthread;sdmmc;smartconfig_ack;soc;spi_flash;spiffs;tcp_transport;tcpip_adapter;ulp;unity;vfs;wear_levelling;wifi_provisioning;wpa_supplicant;xtensa-debug-module" PARENT_SCOPE)
    set(${var_private_requires} "" PARENT_SCOPE)
    return()
  endif()
  message(FATAL_ERROR "Component not found: ${component}")
endfunction()
