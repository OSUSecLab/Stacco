#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <poll.h>

#include <tls.h>

void foo() {}
void bar() {}

int main(int argc, char **argv) {

	struct tls_config *config = NULL;
	struct tls *tls = NULL;
	unsigned int protocols = 0;
	struct sockaddr_in server, client;
	int sockfd = socket(AF_INET, SOCK_STREAM, 0);
	int opt = 1;
	int b;
	struct tls *tls2 = NULL;
	ssize_t outlen = 0;
	char bufs[1000], bufc[1000];
	int sc;
	char *msg = "HELLO TLS CLIENT\n";

	char *ciphers = "AES128-SHA";

	struct pollfd pfd[2];

	if(tls_init() < 0) {
		printf("tls_init error\n");
		exit(1);
	}

	config = tls_config_new();
	if(config == NULL) {
		printf("tls_config_new error\n");
		exit(1);
	}

	tls = tls_server();
	if(tls == NULL) {
		printf("tls_server error\n");
		exit(1);
	}

	protocols = TLS_PROTOCOL_TLSv1_2;

	tls_config_set_protocols(config, protocols);

	if(tls_config_set_ciphers(config, ciphers) < 0) {
		printf("tls_config_set_ciphers error\n");
		exit(1);
	}

	if(tls_config_set_ca_path(config, "/home/user/cacert/") < 0) {
		printf("tls_config_set_key_file error\n");
		exit(1);
	}

	if(tls_config_set_ca_file(config, "/home/user/cacert/ca.crt") < 0) {
		printf("tls_config_set_key_file error\n");
		exit(1);
	}

	if(tls_config_set_key_file(config, "/home/user/cacert/ssl_server.key") < 0) {
		printf("tls_config_set_key_file error\n");
		exit(1);
	}

	if(tls_config_set_cert_file(config, "/home/user/cacert/ssl_server.crt") < 0) {
		printf("tls_config_set_cert_file error\n");
		exit(1);
	}

	if(tls_configure(tls, config) < 0) {
		printf("tls_configure error: %s\n", tls_error(tls));
		exit(1);
	}


	bzero(&server, sizeof(server));
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(8888);
	server.sin_family = AF_INET;

	assert(setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof opt) == 0);
    if (bind(sockfd, (struct sockaddr *)&server, sizeof server) < 0)
    {
        perror("bind()");
        return -1;
    }

    if (listen(sockfd, 128) < 0)
    {
        perror("listen()");
        return -1;
    }

    int count = 0;
    for (; ;)
    {
        struct sockaddr_in client_addr;
        struct tls *tls_cctx;
        socklen_t len = sizeof client_addr;
        ssize_t read, written;

        int fd = accept(sockfd, (struct sockaddr *)&client_addr, &len);
        if (fd < 0)
        {
            perror("accpet()");
            return -1;
        }

        if (tls_accept_socket(tls, &tls_cctx, fd) < 0)
        {
            printf("tls_accept_socket() failed: %s\n", tls_error(tls));
            tls_cctx = NULL;
            continue;
        }

        bzero(bufc, sizeof bufc);

if (count == 1) { 
  printf("foo\n");
  foo();
}
        read = tls_read(tls_cctx, bufc, 5);
        
if (count == 1) { 
  bar(); 
  printf("bar\n");
}
        if (read < 0)
        {
            printf("tls_read failed: %s\n", tls_error(tls_cctx));
            if (count == 1)
                return -1;
            else
                count++;
            continue;
        }
        printf("read: %s\n", bufc);

        tls_close(tls_cctx);
        tls_free(tls_cctx);
    }

    tls_close(tls);
    tls_free(tls);
    tls_config_free(config);

    return 0;
}
