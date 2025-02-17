
#include <stdio.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <sys/socket.h>

#define PORT 8080

void init_server() {
        printf("=== Starting Server ===\n");
        int server_fd;
        struct sockaddr_in server_addr;

        server_fd = socket(AF_INET, SOCK_STREAM, 0);
        if (server_fd < 0) {
                perror("Failed to Create the Socket\n");
                exit(EXIT_FAILURE);
        }
        server_addr.sin_family = AF_INET;
        server_addr.sin_addr.s_addr = INADDR_ANY;
        server_addr.sin_port = htons(PORT);

        if (bind(server_fd, (struct sockaddr *) &server_addr, sizeof(server_addr)) < 0) {
                perror("Failed to Bind\n");
                exit(EXIT_FAILURE);
        }

        if (listen(server_fd, 10) < 0) { /* 10 is the max num of pending connections */
                perror("Failed to Listen\n");
                exit(EXIT_FAILURE);
        }
}

int main() {
        init_server();
}

