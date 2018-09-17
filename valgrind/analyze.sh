#python ../xml_trace.py -i incorrect0.out -o incorrect0.xml
#python ../xml_trace.py -i incorrect1.out -o incorrect1.xml
#python ../xml_trace.py -i incorrect2.out -o incorrect2.xml
#python ../xml_trace.py -i incorrect3.out -o incorrect3.xml
#python ../xml_trace.py -i incorrect4.out -o incorrect4.xml
#python ../xml_trace.py -i incorrect5.out -o incorrect5.xml
python ../xml_trace.py -i incorrect6.out -o incorrect6.xml
python ../xml_trace.py -i incorrect7.out -o incorrect7.xml
python ../xml_trace.py -i incorrect8.out -o incorrect8.xml
python ../xml_trace.py -i incorrect10.out -o incorrect10.xml
python ../xml_trace.py -i correct.out -o correct.xml
python ../xml_trace.py -i incorrect9.out -o incorrect9.xml
sh diff.sh
