/**
 * TLS-Attacker - A Modular Penetration Testing Framework for TLS
 *
 * Copyright 2014-2016 Ruhr University Bochum / Hackmanit GmbH
 *
 * Licensed under Apache License 2.0
 * http://www.apache.org/licenses/LICENSE-2.0
 */
package de.rub.nds.tlsattacker.attacks.impl;

import de.rub.nds.tlsattacker.attacks.config.BleichenbacherCommandConfig;
import de.rub.nds.tlsattacker.tls.Attacker;
import de.rub.nds.tlsattacker.attacks.pkcs1.PKCS1VectorGenerator;
import de.rub.nds.tlsattacker.modifiablevariable.bytearray.ByteArrayModificationFactory;
import de.rub.nds.tlsattacker.modifiablevariable.bytearray.ModifiableByteArray;
import de.rub.nds.tlsattacker.tls.config.ConfigHandler;
import de.rub.nds.tlsattacker.tls.config.WorkflowTraceSerializer;
import de.rub.nds.tlsattacker.tls.protocol.ProtocolMessage;
import de.rub.nds.tlsattacker.tls.constants.AlertDescription;
import de.rub.nds.tlsattacker.tls.constants.AlertLevel;
import de.rub.nds.tlsattacker.tls.protocol.alert.AlertMessage;
import de.rub.nds.tlsattacker.tls.constants.ProtocolMessageType;
import de.rub.nds.tlsattacker.tls.constants.HandshakeMessageType;
import de.rub.nds.tlsattacker.tls.protocol.handshake.RSAClientKeyExchangeMessage;
import de.rub.nds.tlsattacker.tls.util.CertificateFetcher;
import de.rub.nds.tlsattacker.tls.util.LogLevel;
import de.rub.nds.tlsattacker.tls.workflow.TlsContext;
import de.rub.nds.tlsattacker.tls.workflow.WorkflowExecutor;
import de.rub.nds.tlsattacker.tls.workflow.WorkflowTrace;
import de.rub.nds.tlsattacker.transport.TransportHandler;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.interfaces.RSAPublicKey;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;
import javax.xml.bind.JAXBException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Sends differently formatted PKCS#1 messages to the TLS server and observes
 * the server responses. In case there are differences in the server responses,
 * it is very likely that it is possible to execute Bleichenbacher attacks.
 * 
 * @author Juraj Somorovsky <juraj.somorovsky@rub.de>
 */
public class BleichenbacherAttack extends Attacker<BleichenbacherCommandConfig> {

    private static final Logger LOGGER = LogManager.getLogger(BleichenbacherAttack.class);

    public BleichenbacherAttack(BleichenbacherCommandConfig config) {
	super(config);
    }

    @Override
    public void executeAttack(ConfigHandler configHandler) {
	RSAPublicKey publicKey;
	try {
	    publicKey = (RSAPublicKey) CertificateFetcher.fetchServerPublicKey(config);
	    LOGGER.info("Fetched the following server public key: " + publicKey);
	} catch (Exception e) {
	    LOGGER.log(LogLevel.CONSOLE_OUTPUT, "{}, No connection possible: {}", config.getConnect(),
		    e.getLocalizedMessage());
	    return;
	}

	List<ProtocolMessage> protocolMessages = new LinkedList<>();
	byte[][] vectors = PKCS1VectorGenerator.generatePkcs1Vectors(publicKey, config.getType(), config.getError());
	// LOGGER.info("YYYYYYYYY");
	Scanner scanner = new Scanner(System.in);
	for (byte[] vector : vectors) {
		// LOGGER.info("XXXXXXXX");
	    ProtocolMessage pm = executeTlsFlow(configHandler, vector);
	    protocolMessages.add(pm);
	    // System.out.println("Ready for next connection? (y)");
	    // byte yes = scanner.nextByte();
	    // while (yes != 'y')
	    // 	yes = scanner.nextByte();
	}

	LOGGER.info("The following list of protocol messages was found (the last protocol message in the client-server communication):");
	for (ProtocolMessage pm : protocolMessages) {
	    LOGGER.info("Sent by: {}, Type: {}", pm.getMessageIssuer(), pm.getProtocolMessageType());
	    if (pm.getProtocolMessageType() == ProtocolMessageType.ALERT) {
		AlertMessage alert = (AlertMessage) pm;
		AlertDescription ad = AlertDescription.getAlertDescription(alert.getDescription().getValue());
		AlertLevel al = AlertLevel.getAlertLevel(alert.getLevel().getValue());
		LOGGER.info("  Alert {}: {}", al, ad);
	    }
	}
	HashSet<ProtocolMessage> protocolMessageSet = new HashSet<>(protocolMessages);
	StringBuilder sb = new StringBuilder("[");
	for (ProtocolMessage pm : protocolMessageSet) {
	    sb.append(pm.toCompactString()).append(' ');
	}
	sb.append(']');
	if (protocolMessageSet.size() == 1) {
	    LOGGER.log(LogLevel.CONSOLE_OUTPUT, "{}, NOT vulnerable, one message found: {}", config.getConnect(),
		    sb.toString());
            vulnerable = false;
	} else {
	    LOGGER.log(LogLevel.CONSOLE_OUTPUT, "{}, Vulnerable (probably), found: {}", config.getConnect(),
		    sb.toString());
            vulnerable = true;
	}

    }

    private ProtocolMessage executeTlsFlow(ConfigHandler configHandler, byte[] encryptedPMS) {
	// we are initializing a new connection in every loop step, since most
	// of the known servers close the connection after an invalid handshake
	TransportHandler transportHandler = configHandler.initializeTransportHandler(config);
	TlsContext tlsContext = configHandler.initializeTlsContext(config);
	WorkflowExecutor workflowExecutor = configHandler.initializeWorkflowExecutor(transportHandler, tlsContext);

	WorkflowTrace trace = tlsContext.getWorkflowTrace();
	RSAClientKeyExchangeMessage cke = (RSAClientKeyExchangeMessage) trace
		.getFirstHandshakeMessage(HandshakeMessageType.CLIENT_KEY_EXCHANGE);
	ModifiableByteArray epms = new ModifiableByteArray();
	epms.setModification(ByteArrayModificationFactory.explicitValue(encryptedPMS));
	cke.setEncryptedPremasterSecret(epms);
	try {
	    FileOutputStream fos = new FileOutputStream("/tmp/test.xml");
	    WorkflowTraceSerializer.write(fos, trace);
	} catch (IOException | JAXBException ex) {
	    ex.printStackTrace();
	}

	workflowExecutor.executeWorkflow();

	tlsContexts.add(tlsContext);

	transportHandler.closeConnection();
	return trace.getProtocolMessages().get(trace.getProtocolMessages().size() - 1);
    }

}
