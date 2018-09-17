~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_correct/log_0.dcfg.json.bz2 bleichenbacher_correct/log_0.trace.json.bz2 bleichenbacher_correct/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect0/log_0.dcfg.json.bz2 bleichenbacher_incorrect0/log_0.trace.json.bz2 bleichenbacher_incorrect0/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect1/log_0.dcfg.json.bz2 bleichenbacher_incorrect1/log_0.trace.json.bz2 bleichenbacher_incorrect1/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect2/log_0.dcfg.json.bz2 bleichenbacher_incorrect2/log_0.trace.json.bz2 bleichenbacher_incorrect2/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect3/log_0.dcfg.json.bz2 bleichenbacher_incorrect3/log_0.trace.json.bz2 bleichenbacher_incorrect3/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect4/log_0.dcfg.json.bz2 bleichenbacher_incorrect4/log_0.trace.json.bz2 bleichenbacher_incorrect4/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect5/log_0.dcfg.json.bz2 bleichenbacher_incorrect5/log_0.trace.json.bz2 bleichenbacher_incorrect5/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect6/log_0.dcfg.json.bz2 bleichenbacher_incorrect6/log_0.trace.json.bz2 bleichenbacher_incorrect6/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect7/log_0.dcfg.json.bz2 bleichenbacher_incorrect7/log_0.trace.json.bz2 bleichenbacher_incorrect7/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect8/log_0.dcfg.json.bz2 bleichenbacher_incorrect8/log_0.trace.json.bz2 bleichenbacher_incorrect8/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect9/log_0.dcfg.json.bz2 bleichenbacher_incorrect9/log_0.trace.json.bz2 bleichenbacher_incorrect9/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ bleichenbacher_incorrect10/log_0.dcfg.json.bz2 bleichenbacher_incorrect10/log_0.trace.json.bz2 bleichenbacher_incorrect10/bbtrace.txt

~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc1/log_0.dcfg.json.bz2 cbc1/log_0.trace.json.bz2 cbc1/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc2/log_0.dcfg.json.bz2 cbc2/log_0.trace.json.bz2 cbc2/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc3_00/log_0.dcfg.json.bz2 cbc3_00/log_0.trace.json.bz2 cbc3_00/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc3_FF/log_0.dcfg.json.bz2 cbc3_FF/log_0.trace.json.bz2 cbc3_FF/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc4/log_0.dcfg.json.bz2 cbc4/log_0.trace.json.bz2 cbc4/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc5_00/log_0.dcfg.json.bz2 cbc5_00/log_0.trace.json.bz2 cbc5_00/bbtrace.txt
~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/bin/intel64/dcfg-differ cbc5_FF/log_0.dcfg.json.bz2 cbc5_FF/log_0.trace.json.bz2 cbc5_FF/bbtrace.txt

echo 'diff correct bleichenbacher'
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > diff_b0.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > diff_b1.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > diff_b2.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > diff_b3.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > diff_b4.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > diff_b5.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > diff_b6.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > diff_b7.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > diff_b8.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > diff_b9.txt
diff bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > diff_b10.txt

echo 'diff incorrect9 bleichenbacher'
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > diff_b90.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > diff_b91.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > diff_b92.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > diff_b93.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > diff_b94.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > diff_b95.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > diff_b96.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > diff_b97.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > diff_b98.txt
diff bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > diff_b910.txt

echo 'diff incorrect10 bleichenbacher'
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > diff_b100.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > diff_b101.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > diff_b102.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > diff_b103.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > diff_b104.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > diff_b105.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > diff_b106.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > diff_b107.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > diff_b108.txt
diff bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > diff_b109.txt

echo 'diff cbc'
diff cbc1/bbtrace.txt cbc2/bbtrace.txt > diff_cbc2.txt
diff cbc1/bbtrace.txt cbc3_00/bbtrace.txt > diff_cbc3_00.txt
diff cbc1/bbtrace.txt cbc3_FF/bbtrace.txt > diff_cbc3_FF.txt
diff cbc1/bbtrace.txt cbc4/bbtrace.txt > diff_cbc4.txt
diff cbc1/bbtrace.txt cbc5_00/bbtrace.txt > diff_cbc5_00.txt
diff cbc1/bbtrace.txt cbc5_FF/bbtrace.txt > diff_cbc5_FF.txt

echo 'page: analyze correct bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b0.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > vul_b0.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b1.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > vul_b1.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b2.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > vul_b2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b3.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > vul_b3.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b4.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > vul_b4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b5.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > vul_b5.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b6.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > vul_b6.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b7.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > vul_b7.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b8.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > vul_b8.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b9.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > vul_b9.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b10.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > vul_b10.txt

echo 'page: analyze incorrect9 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b90.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > vul_b90.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b91.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > vul_b91.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b92.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > vul_b92.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b93.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > vul_b93.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b94.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > vul_b94.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b95.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > vul_b95.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b96.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > vul_b96.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b97.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > vul_b97.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b98.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > vul_b98.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b910.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > vul_b910.txt

echo 'page: analyze incorrect10 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b100.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > vul_b100.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b101.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > vul_b101.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b102.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > vul_b102.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b103.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > vul_b103.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b104.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > vul_b104.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b105.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > vul_b105.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b106.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > vul_b106.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b107.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > vul_b107.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b108.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > vul_b108.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_b109.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > vul_b109.txt

echo 'page: analyze cbc'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc2.txt cbc1/bbtrace.txt cbc2/bbtrace.txt > vul_cbc2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc3_00.txt cbc1/bbtrace.txt cbc3_00/bbtrace.txt > vul_cbc3_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc3_FF.txt cbc1/bbtrace.txt cbc3_FF/bbtrace.txt > vul_cbc3_FF.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc4.txt cbc1/bbtrace.txt cbc4/bbtrace.txt > vul_cbc4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc5_00.txt cbc1/bbtrace.txt cbc5_00/bbtrace.txt > vul_cbc5_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-vulnerability-detector.py diff_cbc5_FF.txt cbc1/bbtrace.txt cbc5_FF/bbtrace.txt > vul_cbc5_FF.txt

echo 'page: purge correct bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b0.txt > purged_vul_b0.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b1.txt > purged_vul_b1.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b2.txt > purged_vul_b2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b3.txt > purged_vul_b3.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b4.txt > purged_vul_b4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b5.txt > purged_vul_b5.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b6.txt > purged_vul_b6.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b7.txt > purged_vul_b7.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b8.txt > purged_vul_b8.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b9.txt > purged_vul_b9.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b10.txt > purged_vul_b10.txt

echo 'page: purge incorrect9 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b90.txt > purged_vul_b90.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b91.txt > purged_vul_b91.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b92.txt > purged_vul_b92.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b93.txt > purged_vul_b93.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b94.txt > purged_vul_b94.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b95.txt > purged_vul_b95.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b96.txt > purged_vul_b96.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b97.txt > purged_vul_b97.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b98.txt > purged_vul_b98.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b910.txt > purged_vul_b910.txt

echo 'page: purge incorrect10 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b100.txt > purged_vul_b100.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b101.txt > purged_vul_b101.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b102.txt > purged_vul_b102.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b103.txt > purged_vul_b103.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b104.txt > purged_vul_b104.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b105.txt > purged_vul_b105.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b106.txt > purged_vul_b106.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b107.txt > purged_vul_b107.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b108.txt > purged_vul_b108.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_b109.txt > purged_vul_b109.txt

echo 'page: purge cbc'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc2.txt > purged_vul_cbc2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc3_00.txt > purged_vul_cbc3_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc3_FF.txt > purged_vul_cbc3_FF.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc4.txt > purged_vul_cbc4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc5_00.txt > purged_vul_cbc5_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/pgfault-purge.py vul_cbc5_FF.txt > purged_vul_cbc5_FF.txt

echo 'cache: analyze correct bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b0.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > cvul_b0.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b1.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > cvul_b1.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b2.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > cvul_b2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b3.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > cvul_b3.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b4.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > cvul_b4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b5.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > cvul_b5.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b6.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > cvul_b6.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b7.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > cvul_b7.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b8.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > cvul_b8.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b9.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > cvul_b9.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b10.txt bleichenbacher_correct/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > cvul_b10.txt

echo 'cache: analyze incorrect9 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b90.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > cvul_b90.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b91.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > cvul_b91.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b92.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > cvul_b92.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b93.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > cvul_b93.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b94.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > cvul_b94.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b95.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > cvul_b95.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b96.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > cvul_b96.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b97.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > cvul_b97.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b98.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > cvul_b98.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b910.txt bleichenbacher_incorrect9/bbtrace.txt bleichenbacher_incorrect10/bbtrace.txt > cvul_b910.txt

echo 'cache: analyze incorrect10 bleichenbacher'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b100.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect0/bbtrace.txt > cvul_b100.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b101.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect1/bbtrace.txt > cvul_b101.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b102.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect2/bbtrace.txt > cvul_b102.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b103.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect3/bbtrace.txt > cvul_b103.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b104.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect4/bbtrace.txt > cvul_b104.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b105.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect5/bbtrace.txt > cvul_b105.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b106.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect6/bbtrace.txt > cvul_b106.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b107.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect7/bbtrace.txt > cvul_b107.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b108.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect8/bbtrace.txt > cvul_b108.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_b109.txt bleichenbacher_incorrect10/bbtrace.txt bleichenbacher_incorrect9/bbtrace.txt > cvul_b109.txt

echo 'cache: analyze cbc'
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc2.txt cbc1/bbtrace.txt cbc2/bbtrace.txt > cvul_cbc2.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc3_00.txt cbc1/bbtrace.txt cbc3_00/bbtrace.txt > cvul_cbc3_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc3_FF.txt cbc1/bbtrace.txt cbc3_FF/bbtrace.txt > cvul_cbc3_FF.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc4.txt cbc1/bbtrace.txt cbc4/bbtrace.txt > cvul_cbc4.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc5_00.txt cbc1/bbtrace.txt cbc5_00/bbtrace.txt > cvul_cbc5_00.txt
python ~/Downloads/pinplay-drdebug-pldi2016-3.0-pin-3.0-76991-gcc-linux/extras/dcfg/examples/cache-vulnerability-detector.py diff_cbc5_FF.txt cbc1/bbtrace.txt cbc5_FF/bbtrace.txt > cvul_cbc5_FF.txt