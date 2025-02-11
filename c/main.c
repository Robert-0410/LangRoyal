#include <netinet/in.h>
#include <stdio.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>

#include "server.h"

void launch(struct Server *server) {
        char buffer[1024];
        char *test_res = "Hello with C HTTP!";
        /*int address_size = sizeof(server->address);*/
        uint64_t address_size = sizeof(server->address);
        int new_socket;
        while(1) {
                memset(buffer, 0, 1024);
                printf("===== WAITING FOR CONNECTION =====\n");
                new_socket = accept(
                        server->socket,
                        (struct sockaddr *) &server->address,
                        (socklen_t *) address_size
                );

                read(new_socket, buffer, 1024);
                printf("%s\n", buffer);

                /* Responce */
                write(new_socket, test_res, strlen(test_res));
                close(new_socket);
        }

}

int main() {
        struct Server server = server_init(
                AF_INET,
                SOCK_STREAM,
                0,
                INADDR_ANY,
                8000,
                10,
                launch
        );
        server.launch(&server);
}
