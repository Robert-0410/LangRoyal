
#include "server.h"


struct Server server_init(
        int domain,
        int service,
        int protocal,
        u_long interface,
        int port,
        int backlog,
        void (*launch)(void)
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


        return server;
}


