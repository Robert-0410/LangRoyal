
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>

#include "server.h"


struct Server server_init(
        int domain,
        int service,
        int protocal,
        u_long interface,
        int port,
        int backlog,
        void (*launch)(struct Server *server)
) {
        struct Server server;
        server.domain = domain;
        server.service = service;
        server.protocal= protocal;
        server.interface = interface;
        server.port = port;
        server.backlog = backlog;

        server.address.sin_family = domain;
        server.address.sin_port = htons(port); // TODO: i think the port only needs to be uint16_t, check others also.
        server.address.sin_addr.s_addr = htonl(interface);

        server.socket = socket(domain, service, protocal);
        if (server.socket < 0) {
                perror("Failed to connect to socket.\n");
                exit(1);
        }

        int res = bind(server.socket, (struct sockaddr *) &server.address, sizeof(server.address));
        if (res < 0) {
                perror("Failed to bind socket.\n");
                exit(1);
        }

        res = listen(server.socket, server.backlog);
        if (res < 0) {
                perror("Failed to start listening.\n");
                exit(1);
        }

        server.launch = launch;

        return server;
}


