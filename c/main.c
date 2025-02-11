#include <netinet/in.h>
#include <stdio.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>

#include "server.h"

void launch(struct Server *server) {
        printf("===== WAITING FOR CONNECTION =====\n");
        char buffer[1024];
        int address_size = sizeof(server->address);
        int new_socket = accept(server->socket, (struct sockaddr *) &server->address, (socklen_t *) address_size);

        read(new_socket, buffer, 1024);
        printf("%s\n", buffer);

        /* Responce */
        char *test_res = "Hello with C HTTP!";
        write(new_socket, test_res, strlen(test_res));
        close(new_socket);

}

int main() {
        struct Server server = server_init(
                AF_INET,
                SOCK_STREAM,
                0,
                INADDR_ANY,
                80,
                10,
                launch
        );
        server.launch(&server);
}
