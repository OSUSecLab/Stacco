# stacco

Before testing a TLS library with **stacco**, make sure that your server program has valid certificates. To test for Lucky13 and Bleichenbacher side channel vulenrabilities, make sure that your certificate could be used with the ciphersuite *TLS_RSA_WITH_AES_128_CBC_SHA*.

## Intel Pin plugin setup
1. Download [Intel PinPlay toolkit (pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux)](https://software.intel.com/protected-download/366522/366520) and put into directory *"pin"*.

2. Execute command line instructions
```
cd pin
sh patch.sh
cd pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples
make
```

## TLS Attacker setup
1. Download [TLS Attacker (TLS-Attacker-master)](https://github.com/RUB-NDS/TLS-Attacker) and put into directory *"TLS-Attacker"*. Notice that you need to have Java installed.

2. Execute command line instructions
```
cd TLS-Attacker
sh patch.sh
cd TLS-Attacker-master
./mvnw clean package -DskipTests=true
```

## Use TLS Attacker to generate specific packets to send to the server program using tested library
### Import private key and certificate into java keystore
Sample commands for generating java keystores to be used by TLS Attacker are below. Make sure you change all filenames in the commands correctly.
```
openssl pkcs12 -export -in my.crt -inkey my.key -chain -CAfile my-ca-file.crt -name "my-domain.com" -out my.p12
keytool -importkeystore -deststorepass MY-KEYSTORE-PASS -destkeystore my-keystore.jks -srckeystore my.p12 -srcstoretype PKCS12
```

reference: https://makandracards.com/jan0sch/24553-import-private-key-and-certificate-into-java-keystore

### Lucky13
Start the server program for the tested library. When it is ready to accept TLS connections, use one of the following commands to generate one particular type of client connection packets. Notice that you should change the IP address and port number according to your server program. Also, make sure you change the filename and password of your keystore accordingly. Test samples could be found in the directory *"test"*.
```
java -jar TLS-Attacker-1.2.jar lucky13 -measurements 1 -paddings 255 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 0 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 1 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 2 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 3 -paddingerror 0 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 3 -paddingerror 255 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 4 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 5 -paddingerror 0 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 5 -paddingerror 255 -measurements 1 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

### Bleichenbacher
Similar to Lucky13 tests, start the server program for the tested library. When it is ready to accept TLS connections, use one of the following commands to generate one particular type of client connection packets. Here in the second command, `"-errortype 9"` could be changed into different types of errors ranging from 0 to 10. Details about the error types could be found in the paper or in the source code `"TLS-Attacker/PKCS1VectorGenerator.java"`.
```
java -jar TLS-Attacker-1.2.jar bleichenbacher -type CORRECT -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar bleichenbacher -type INCORRECT -errortype 9 -connect 192.168.1.110:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

*For gnutls, remove `"-client_authentication"`

```
java -Djava.library.path="../../Utils/src/main/java/" -jar TLS-Attacker-1.2.jar bleichenbacher -type CORRECT -connect 164.107.119.231:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

## Use pintool DCFG to capture and analyze execution trace
In order to do analysis on the server programs, use Intel Pin or Valgrind (next section) to monitor and record sensitive parts of its execution.

1. Prepare:
`export PIN_ROOT=~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux`

2. Create dcfg & trace (suppose the server program is compiled into ./server and the code to be monitored is wrapped with functions `foo()` and `bar()`; samples could be found in directory *"test"*). Below is an example for openssl:
```
cd test/openssl
$PIN_ROOT/extras/pinplay/scripts/record --pintool $PIN_ROOT/extras/dcfg/bin/intel64/dcfg-driver.so --pintool_options='-dcfg -dcfg:write_trace -dcfg:write_debug -log:control start:address:foo,stop:addres:bar' -- ./server
```
**Note**: -dcfg:write_debug could be removed

3. Analyze dcfg & trace:
```
cd test/openssl/pinball
$PIN_ROOT/extras/dcfg/bin/intel64/dcfg-differ log_0.dcfg.json.bz2 log_0.trace.json.bz2 bbtrace.txt
```

4. Diff two traces:
`diff /some/bbtrace.txt /another/bbtrace.txt > diff.txt`

**Note**: a sample bash script could be found in `"pin/diff.sh"`

5. Perform page level side-channel vulnerability analysis with `pgfault-vulnerability-detector.py` and `pgfault-purge.py`:
```
cd pin
python pgfault-vulnerability-detector.py diff.txt /some/bbtrace.txt /another/bbtrace.txt > vul.txt
python pgfault-purge.py vul.txt > purged_vul.txt
```

6. Perform cacheline level side-channel vulnerability analysis with `cache-vulnerability-detector.py`:
```
cd pin
python cache-vulnerability-detector.py diff.txt /some/bbtrace.txt /another/bbtrace.txt > cvul.txt
```

**Note**: a sample bash script for the complete process of steps 3~6 could be found in `"pin/dcfg2vul.sh"`. As explained in the paper, GnuTLS has some compatibility issues with Intel Pin. So it could only be tested with Valgrind (see next section).

## Use valgrind (callgrind) to analyze on the function call granularity when Intel Pin could not be used on some libraries for compatibility issues.

Code could found in the directory *"valgrind"*. Generate a function call trace using callgrind and then follow the examples in the scripts `purge.sh` and `analyze.sh`. Make sure you replace the key function name in `xml_trace.py` (an example for GnuTLS is provided in `xml_trace_gnutls.py`).
