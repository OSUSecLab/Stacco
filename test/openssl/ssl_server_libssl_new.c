#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
// #include <sys/un.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
// #include <fcntl.h>
// #include <assert.h>

#include <openssl/ssl.h>
#include <openssl/err.h>

#define SSL_SERVER_RSA_CERT	"/home/user/cacert/ssl_server_1024_nopwd.crt"
#define SSL_SERVER_RSA_KEY	"/home/user/cacert/ssl_server_1024_nopwd.key"
#define SSL_SERVER_RSA_CA_CERT	"/home/user/cacert/ca.crt"
#define SSL_SERVER_RSA_CA_PATH	"/home/user/cacert/"

// #define SSL_SERVER_ADDR		"192.168.56.101"

#define OFF	0
#define ON	1

void foo() {}
void bar() {}

int main(void)
{
	int verify_peer = ON;
	// int verify_peer = OFF;
	SSL_METHOD *server_meth;
	SSL_CTX *ssl_server_ctx;
	int serversocketfd;
	int clientsocketfd;
	struct sockaddr_in serveraddr;
	int handshakestatus;

	// SSL_library_init();
	OpenSSL_add_ssl_algorithms();
	SSL_load_error_strings();
	server_meth = TLSv1_2_server_method();
	ssl_server_ctx = SSL_CTX_new(server_meth);
	
	if(!ssl_server_ctx)
	{
		ERR_print_errors_fp(stderr);
		return -1;
	}

	int stat = SSL_CTX_set_cipher_list(ssl_server_ctx, "AES128-SHA");
	if (stat == 0) {
		ERR_print_errors_fp(stderr);
	}
	
	if(SSL_CTX_use_certificate_file(ssl_server_ctx, SSL_SERVER_RSA_CERT, SSL_FILETYPE_PEM) <= 0)	
	{
		ERR_print_errors_fp(stderr);
		return -1;		
	}

	
	if(SSL_CTX_use_PrivateKey_file(ssl_server_ctx, SSL_SERVER_RSA_KEY, SSL_FILETYPE_PEM) <= 0)	
	{
		ERR_print_errors_fp(stderr);
		return -1;		
	}
	
	if(SSL_CTX_check_private_key(ssl_server_ctx) != 1)
	{
		printf("Private and certificate is not matching\n");
		return -1;
	}	

	if(verify_peer)
	{	
		//See function man pages for instructions on generating CERT files
		if(!SSL_CTX_load_verify_locations(ssl_server_ctx, SSL_SERVER_RSA_CA_CERT, NULL))
		{
			ERR_print_errors_fp(stderr);
			return -1;		
		}
		SSL_CTX_set_verify(ssl_server_ctx, SSL_VERIFY_PEER, NULL);
		SSL_CTX_set_verify_depth(ssl_server_ctx, 1);
	}

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

	printf("Ready for SSL handshake?\n");

	unsigned long count = 0;
	while(1)
	{
		SSL *serverssl;
		int ret;

		clientsocketfd = accept(serversocketfd, NULL, 0);
		serverssl = SSL_new(ssl_server_ctx);
		if(!serverssl)
		{
			printf("Error SSL_new\n");
			return -1;
		}
		SSL_set_fd(serverssl, clientsocketfd);


if (1) { 
  printf("foo\n");
  foo();
}
		ret = SSL_accept(serverssl);

if (1) { 
  bar(); 
  printf("bar\n");
}

		if((ret) != 1)
		{
			if (count % 100 >= 0) {
				int err_SSL_get_error = SSL_get_error(serverssl, ret);
				printf("%lu Handshake Error %d: ", count, err_SSL_get_error);
				switch(err_SSL_get_error) {
			    	case SSL_ERROR_NONE:
			    	printf("No error\n");
			    	break;

			    	case SSL_ERROR_ZERO_RETURN:
			    	printf("The TLS/SSL connection has been closed.\n");
			    	break;

			    	case SSL_ERROR_WANT_READ:
			    	case SSL_ERROR_WANT_WRITE:
			    	printf("SSL_ERROR_WANT_READ/WRITE\n");
			    	break;

			    	case SSL_ERROR_WANT_CONNECT:
			    	case SSL_ERROR_WANT_ACCEPT:
			    	printf("SSL_ERROR_WANT_CONNECT/ACCEPT\n");
			    	break;

			    	case SSL_ERROR_WANT_X509_LOOKUP:
			    	printf("SSL_ERROR_WANT_X509_LOOKUP\n");
			    	break;

			    	// case SSL_ERROR_WANT_ASYNC:
			    	// printf("SSL_ERROR_WANT_ASYNC\n");
			    	// break;

			    	// case SSL_ERROR_WANT_ASYNC_JOB:
			    	// printf("SSL_ERROR_WANT_ASYNC_JOB\n");
			    	// break;

			    	case SSL_ERROR_SYSCALL:
			    	printf("SSL_ERROR_SYSCALL\n");
			    	break;

			    	case SSL_ERROR_SSL:
			    	printf("SSL_ERROR_SSL\n");
					close(serversocketfd);
					SSL_CTX_free(ssl_server_ctx);
					return -1;
			    	break;

			    	default:
			    	printf("Unknown error\n");
			    }
			    // printf("Error string %s\n", ERR_error_string( err_SSL_get_error, NULL ));
			}
		    
			count++;
			SSL_shutdown(serverssl);
			close(clientsocketfd);
			clientsocketfd = -1;
			SSL_free(serverssl);
			serverssl = NULL;
			continue;
			// break;
		}

		char buffer[1024];
		int bytesread = 0;
		int addedstrlen;
		
		if(verify_peer)
		{
			X509 *ssl_client_cert = NULL;

			ssl_client_cert = SSL_get_peer_certificate(serverssl);
			
			if(ssl_client_cert)
			{
				long verifyresult;

				verifyresult = SSL_get_verify_result(serverssl);
				if(verifyresult == X509_V_OK)
					printf("Certificate Verify Success\n"); 
				else
					printf("Certificate Verify Failed\n"); 
				X509_free(ssl_client_cert);				
			}
			else
				printf("There is no client certificate\n");
		}

		if (1) {

			printf("Waiting for messages ...\n");

			bytesread = SSL_read(serverssl, buffer, sizeof(buffer));

	        if ((bytesread) <= 0) {
	    		if (bytesread == 0) {
			    	printf("The TLS/SSL connection has been closed.\n");
	    			break;
	    		}
	    		switch(SSL_get_error(serverssl, bytesread)) {
			    	case SSL_ERROR_NONE:
			    	printf("No error\n");
			    	break;

			    	case SSL_ERROR_ZERO_RETURN:
			    	printf("The TLS/SSL connection has been closed.\n");
			    	break;

			    	case SSL_ERROR_WANT_READ:
			    	case SSL_ERROR_WANT_WRITE:
			    	printf("SSL_ERROR_WANT_READ/WRITE\n");
			    	break;

			    	case SSL_ERROR_WANT_CONNECT:
			    	case SSL_ERROR_WANT_ACCEPT:
			    	printf("SSL_ERROR_WANT_CONNECT/ACCEPT\n");
			    	break;

			    	case SSL_ERROR_WANT_X509_LOOKUP:
			    	printf("SSL_ERROR_WANT_X509_LOOKUP\n");
			    	break;

			    	// case SSL_ERROR_WANT_ASYNC:
			    	// printf("SSL_ERROR_WANT_ASYNC\n");
			    	// break;

			    	// case SSL_ERROR_WANT_ASYNC_JOB:
			    	// printf("SSL_ERROR_WANT_ASYNC_JOB\n");
			    	// break;

			    	case SSL_ERROR_SYSCALL:
			    	printf("SSL_ERROR_SYSCALL\n");
			    	break;

			    	case SSL_ERROR_SSL:
			    	printf("SSL_ERROR_SSL\n");
			    	break;

			    	default:
			    	printf("Unknown error\n");
			    }
			    // continue;
				close(serversocketfd);
				SSL_CTX_free(ssl_server_ctx);
			    return -1;
	    	}

	        // printf("SSL client reply: %s\n", buffer);
	        int i;
	        for (i = 0; i < bytesread; i++)
	            printf("%02x", *(buffer+i));
	        printf("\n");
		}

		SSL_shutdown(serverssl);
		close(clientsocketfd);
		clientsocketfd = -1;
		SSL_free(serverssl);
		serverssl = NULL;

			break;
	}
	close(serversocketfd);
	SSL_CTX_free(ssl_server_ctx);
	return 0;	
}
