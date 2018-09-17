// #include "wolfssl/ssl.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>

#include <wolfssl/options.h>
#include <wolfssl/ssl.h>
#include <wolfssl/test.h>
#include <errno.h>

#define SERV_PORT 8888
#define MAX_LINE 4096

void foo() {}
void bar() {}

int main(int argc, char** argv) 
{
    int serversocketfd, clientsocketfd;
    WOLFSSL_CTX* ctx;
    WOLFSSL* ssl;
    int n;
    char buf[MAX_LINE];
    WOLFSSL_METHOD* method;
    struct sockaddr_in serveraddr;

    /* Initialize wolfSSL library */
    wolfSSL_Init();

    /* Get encryption method */
    method = wolfTLSv1_2_server_method();

    /* Create wolfSSL_CTX */
    if ( (ctx = wolfSSL_CTX_new(method)) == NULL) 
        err_sys("wolfSSL_CTX_new error");

    if ( wolfSSL_CTX_set_cipher_list(ctx, "AES128-SHA") == 0)
    	err_sys("wolfSSL_CTX_set_cipher_list error");

    /* Load server certs into ctx */
    if (wolfSSL_CTX_use_certificate_file(ctx, "/home/user/cacert/ssl_server.crt",
                SSL_FILETYPE_PEM) != SSL_SUCCESS) 
        err_sys("Error loading /home/user/cacert/ssl_server.crt");

    /* Load server key into ctx */
    if (wolfSSL_CTX_use_PrivateKey_file(ctx, "/home/user/cacert/ssl_server.pem",
                SSL_FILETYPE_PEM) != SSL_SUCCESS)
        err_sys("Error loading /home/user/cacert/ssl_server.pem");

	if((serversocketfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		printf("Error on socket creation\n");
		return -1;
	}
	// memset(&serveraddr, 0, sizeof(struct sockaddr_in));
	serveraddr.sin_family = AF_INET;
	serveraddr.sin_addr.s_addr = INADDR_ANY;
	serveraddr.sin_port = htons(8888);

	int optval = 1;

	setsockopt(serversocketfd, SOL_SOCKET, SO_REUSEADDR, (void *) &optval,
                   sizeof(int));

	if(bind(serversocketfd, (struct sockaddr *)&serveraddr, sizeof(struct sockaddr_in)))
	{
		printf("server bind error\n");
		return -1;
	}
	
	if(listen(serversocketfd, SOMAXCONN))
	{
		printf("Error on listen\n");
		return -1;
	}

	int count = 0;
	while(1) {
		clientsocketfd = accept(serversocketfd, NULL, 0);
	    /* Create wolfSSL object */
	    if ( (ssl = wolfSSL_new(ctx)) == NULL) 
	        err_sys("wolfSSL_new error");

	    wolfSSL_set_fd(ssl, clientsocketfd);

if (count == 1) { 
  printf("foo\n");
  foo();
}

n = wolfSSL_read(ssl, buf, (sizeof(buf) -1));

if (count == 1) { 
  bar(); 
  printf("bar\n");
}

	    if ( n > 0) {
	        printf("%s\n", buf);
	        if (wolfSSL_write(ssl, buf, n) != n)
	            err_sys("wolfSSL_write error");
	    }
	    if (n <0) 
	        printf("wolfSSL_read error = %d\n", wolfSSL_get_error(ssl, n));
	    else if (n == 0)
	        printf("Connection close by peer\n");

	    wolfSSL_free(ssl);
	    close(clientsocketfd);
	    if (n < 0 && count == 1)
	    	break;
	    count++;
	}

    wolfSSL_CTX_free(ctx);
    wolfSSL_Cleanup();
    exit(EXIT_SUCCESS);
}
