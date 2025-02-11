#ifndef server_h
#define server_h

#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/types.h>

struct Server {
	int domain;
	int service;
	int protocal;
	u_long interface;
	int port;
	int backlog;

	struct sockaddr_in address;

	int socket;

	void (*launch)(struct Server *server);
};

struct Server server_init(
	int domain,
	int service,
	int protocal,
	u_long interface,
	int port,
	int backlog,
	void (*launch)(struct Server *server)
);

#endif /* server_h */
