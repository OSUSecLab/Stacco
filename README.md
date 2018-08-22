# stacco

Before testing a TLS library with **stacco**, make sure that your server program has valid certificates. To test for Lucky13 and Bleichenbacher side channel vulenrabilities, make sure that your certificate could be used with the ciphersuite *TLS_RSA_WITH_AES_128_CBC_SHA*.

## Intel Pin plugin setup
1. Download [Intel PinPlay toolkit (pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux)](https://software.intel.com/protected-download/366522/366520) and put into directory "pin".

2. Execute command line instructions
```
cd pin
sh patch.sh
cd pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples
make
```

## TLS Attacker setup
1. Download [TLS Attacker (TLS-Attacker-master)](https://github.com/RUB-NDS/TLS-Attacker) and put into directory "TLS-Attacker". Notice that you need to have Java installed.

2. Execute command line instructions
```
cd TLS-Attacker
sh patch.sh
cd TLS-Attacker-master
./mvnw clean package -DskipTests=true
```

## Use TLS Attacker to generate specific packets to send to the server program using tested library
### Import private key and certificate into java keystore
```
openssl pkcs12 -export -in my.crt -inkey my.key -chain -CAfile my-ca-file.crt -name "my-domain.com" -out my.p12
keytool -importkeystore -deststorepass MY-KEYSTORE-PASS -destkeystore my-keystore.jks -srckeystore my.p12 -srcstoretype PKCS12
```

reference: https://makandracards.com/jan0sch/24553-import-private-key-and-certificate-into-java-keystore

### Lucky13
```
java -jar TLS-Attacker-1.2.jar lucky13 -measurements 1 -paddings 255 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 0 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 1 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 2 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 3 -paddingerror 0 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 3 -paddingerror 255 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 4 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 5 -paddingerror 0 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar packetgeneration -errortype 5 -paddingerror 255 -measurements 1 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

### Bleichenbacher
```
java -jar TLS-Attacker-1.2.jar bleichenbacher -type CORRECT -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
java -jar TLS-Attacker-1.2.jar bleichenbacher -type INCORRECT -errortype 9 -connect 164.107.119.233:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

*For gnutls, remove -client_authentication and change keystore path.

```
java -Djava.library.path="../../Utils/src/main/java/" -jar TLS-Attacker-1.2.jar bleichenbacher -type CORRECT -connect 164.107.119.231:8888 -keystore ~/cacert/ssl_client.jks -password xiaoyuan -alias 1 -client_authentication -tls_timeout 20000
```

## Use pintool DCFG to capture and analyze execution trace
1. Prepare:
`export PIN_ROOT=~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux`

2. Create dcfg & trace (suppose the server program is compiled into ./server and the code to be monitored is wrapped with functions `foo()` and `bar()`):
```
cd ~/ssl/gnutls
$PIN_ROOT/extras/pinplay/scripts/record --pintool $PIN_ROOT/extras/dcfg/bin/intel64/dcfg-driver.so --pintool_options='-dcfg -dcfg:write_trace -dcfg:write_debug -log:control start:address:foo,stop:addres:bar' -- ./server
```
* Note: -dcfg:write_debug could be removed

3. Analyze dcfg & trace:
```
cd ~/ssl/gnutls/pinball
$PIN_ROOT/extras/dcfg/bin/intel64/dcfg-differ log_0.dcfg.json.bz2 log_0.trace.json.bz2 bbtrace.txt
```

4. Diff two traces:
`diff /some/bbtrace.txt /another/bbtrace.txt > diff.txt`

5. Perform page level side-channel vulnerability analysis with `pgfault-purge.py` and `pgfault-vulnerability-detector.py`

6. Perform cacheline level side-channel vulnerability analysis with `cache-vulnerability-detector.py`

## Use valgrind (callgrind) to analyze on the function call granularity when Intel Pin could not be used on some libraries for compatibility issues.

Code could found in the directory "valgrind". Generate a function call trace using callgrind and then follow the examples in the scripts `purge.sh` and `analyze.sh`. Make sure you replace the key function name in `xml_trace.py` (an example for GnuTLS is provided in `xml_trace.py`).
