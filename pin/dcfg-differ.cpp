#include "dcfg_api.H"
#include "dcfg_trace_api.H"

#include <stdlib.h>
#include <assert.h>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>

using namespace std;
using namespace dcfg_api;
using namespace dcfg_trace_api;

// Class to collect and print some simple statistics.
class Stats {
    UINT64 _count, _sum, _max, _min;

public:
    Stats() : _count(0), _sum(0), _max(0), _min(0) { }

    void addVal(UINT64 val, UINT64 num=1) {
        _sum += val;
        if (!_count || val > _max)
            _max = val;
        if (!_count || val < _min)
            _min = val;
        _count += num;
    }

    UINT64 getCount() const {
        return _count;
    }

    UINT64 getSum() const {
        return _sum;
    }

    float getAve() const {
        return _count ? (float(_sum) / _count) : 0.f;
    }

    void print(int indent, string valueName, string containerName) {
        for (int i = 0; i < indent; i++)
            cout << " ";
        cout << "Num " << valueName << " = " << getSum();
        if (_count)
            cout << ", ave " << valueName << "/" <<
                containerName << " = " << getAve() <<
                " (max = " << _max << ", min = " << _min << ")";
        cout << endl;
    }
};

// Summarize DCFG contents.
void summarizeDcfg(DCFG_DATA_CPTR dcfg) {

    // output averages to 2 decimal places.
    cout << setprecision(2) << fixed;

    cout << "Summary of DCFG:" << endl;

    // processes.
    DCFG_ID_VECTOR proc_ids;
    dcfg->get_process_ids(proc_ids);
    cout << " Num processes           = " << proc_ids.size() << endl;
    for (size_t pi = 0; pi < proc_ids.size(); pi++) {
        DCFG_ID pid = proc_ids[pi];

        // Get info for this process.
        DCFG_PROCESS_CPTR pinfo = dcfg->get_process_info(pid);
        assert(pinfo);
        UINT32 numThreads = pinfo->get_highest_thread_id() + 1;

        cout << " Process " << pid << endl;
        cout << "  Num threads = " << numThreads << endl;
        cout << "  Instr count = " << pinfo->get_instr_count() << endl;
        if (numThreads > 1) {
            for (UINT32 t = 0; t < numThreads; t++)
                cout << "  Instr count on thread " << t <<
                    " = " << pinfo->get_instr_count_for_thread(t) << endl;
        }

        // Edge IDs.
        DCFG_ID_SET edge_ids;
        pinfo->get_internal_edge_ids(edge_ids);
        cout << "  Num edges   = " << edge_ids.size() << endl;

        // Overall stats.
        Stats bbStats, bbSizeStats, bbCountStats, bbInstrCountStats,
            routineStats, routineCallStats, loopStats, loopTripStats;

        // Images.
        DCFG_ID_VECTOR image_ids;
        pinfo->get_image_ids(image_ids);
        cout << "  Num images  = " << image_ids.size() << endl;
        for (size_t ii = 0; ii < image_ids.size(); ii++) {
            DCFG_IMAGE_CPTR iinfo = pinfo->get_image_info(image_ids[ii]);
            assert(iinfo);

            // Basic block, routine and loop IDs for this image.
            DCFG_ID_VECTOR bb_ids, routine_ids, loop_ids;
            iinfo->get_basic_block_ids(bb_ids);
            iinfo->get_routine_ids(routine_ids);
            iinfo->get_loop_ids(loop_ids);

            cout << "  Image " << image_ids[ii] << endl;
            cout << "   Load addr        = 0x" << hex << iinfo->get_base_address() << dec << endl;
            cout << "   Size             = " << iinfo->get_size() << endl;
            cout << "   File             = '" << *iinfo->get_filename() << "'" << endl;
            cout << "   Num basic blocks = " << bb_ids.size() << endl;
            cout << "   Num routines     = " << routine_ids.size() << endl;
            cout << "   Num loops        = " << loop_ids.size() << endl;

            // Basic blocks.
            bbStats.addVal(bb_ids.size());
            for (size_t bi = 0; bi < bb_ids.size(); bi++) {
                if (pinfo->is_special_node(bb_ids[bi]))
                    continue;
                DCFG_BASIC_BLOCK_CPTR bbinfo = pinfo->get_basic_block_info(bb_ids[bi]);
                assert(bbinfo);

                bbSizeStats.addVal(bbinfo->get_num_instrs());
                bbCountStats.addVal(bbinfo->get_exec_count());
                bbInstrCountStats.addVal(bbinfo->get_instr_count(), bbinfo->get_exec_count());
            }
                
            // Routines.
            routineStats.addVal(routine_ids.size());
            for (size_t ri = 0; ri < routine_ids.size(); ri++) {
                DCFG_ROUTINE_CPTR rinfo = iinfo->get_routine_info(routine_ids[ri]);
                assert(rinfo);
                routineCallStats.addVal(rinfo->get_entry_count());
            }

            // Loops.
            loopStats.addVal(loop_ids.size());
            for (size_t li = 0; li < loop_ids.size(); li++) {
                DCFG_LOOP_CPTR linfo = iinfo->get_loop_info(loop_ids[li]);
                assert(linfo);
                loopTripStats.addVal(linfo->get_iteration_count());
            }
        }

        cout << " Process " << pid << " summary:" << endl;
        routineStats.print(2, "routines", "image");
        routineCallStats.print(2, "routine calls", "routine");
        loopStats.print(2, "loops", "image");
        loopTripStats.print(2, "loop iterations", "loop");
        bbStats.print(2, "basic blocks", "image");
        bbSizeStats.print(2, "static instrs", "basic block");
        bbCountStats.print(2, "basic-block executions", "basic block");
        bbInstrCountStats.print(2, "dynamic instrs", "basic block execution");
    }
}

// Summarize DCFG trace contents.
void summarizeTrace(DCFG_DATA_CPTR dcfg, string tracefile) {

    // processes.
    DCFG_ID_VECTOR proc_ids;
    dcfg->get_process_ids(proc_ids);
    for (size_t pi = 0; pi < proc_ids.size(); pi++) {
        DCFG_ID pid = proc_ids[pi];

        // Get info for this process.
        DCFG_PROCESS_CPTR pinfo = dcfg->get_process_info(pid);
        assert(pinfo);

        // Make a new reader.
        DCFG_TRACE_READER* traceReader = DCFG_TRACE_READER::new_reader(pid);

        // threads.
        for (UINT32 tid = 0; tid <= pinfo->get_highest_thread_id(); tid++) {

            // Open file.
            cerr << "Reading DCFG trace for PID " << pid <<
                " and TID " << tid << " from '" << tracefile << "'..." << endl;
            string errMsg;
            if (!traceReader->open(tracefile, tid, errMsg)) {
                cerr << "error: " << errMsg << endl;
                return;
            }

            // Header.
            cout << "edge id,basic-block id,basic-block addr,basic-block symbol,num instrs in BB" << endl;

            // Read until done.
            size_t nRead = 0;
            bool done = false;
            DCFG_ID_VECTOR edge_ids;
            while (!done) {

                if (!traceReader->get_edge_ids(edge_ids, done, errMsg))
                {
                    cerr << "error: " << errMsg << endl;
                    done = true;
                }
                nRead += edge_ids.size();
                for (size_t j = 0; j < edge_ids.size(); j++) {
                    DCFG_ID edgeId = edge_ids[j];

                    // Get edge.
                    DCFG_EDGE_CPTR edge = pinfo->get_edge_info(edgeId);
                    if (!edge) continue;
                    if (edge->is_exit_edge_type()) {
                        cout << edgeId << ",end" << endl;
                        continue;
                    }

                    // Get BB at target.
                    DCFG_ID bbId = edge->get_target_node_id();
                    DCFG_BASIC_BLOCK_CPTR bb = pinfo->get_basic_block_info(bbId);
                    if (!bb) continue;
                    const string* symbol = bb->get_symbol_name();
                    
                    // print info.
                    cout << edgeId << ',' << bbId << ',' <<
                        (void*)bb->get_first_instr_addr() << ',' <<
                        '"' << (symbol ? *symbol : "unknown") << '"' << ',' <<
                        bb->get_num_instrs() << endl;
                }
                edge_ids.clear();
            }
            cerr << "Done reading " << nRead << " edges." << endl;
        }
    }
}

// Get the basic block addr offset in the image
DCFG_ID edgeId2bbAddr(DCFG_ID &edge_id, DCFG_PROCESS_CPTR &pinfo, UINT64 &addr_offset)
{
	// Get edge.
	DCFG_EDGE_CPTR edge = pinfo->get_edge_info(edge_id);
	if (!edge) return 0;
	if (edge->is_exit_edge_type())
        addr_offset = 1;

	// Get BB at target.
	DCFG_ID bbId = edge->get_target_node_id();
	DCFG_BASIC_BLOCK_CPTR bb = pinfo->get_basic_block_info(bbId);
	if (!bb) return 0;

	// Get BB addr.
	UINT64 bbBaseAddr = bb->get_first_instr_addr();

	// Get image.
	DCFG_ID imageId = bb->get_image_id();
	DCFG_IMAGE_CPTR image = pinfo->get_image_info(imageId);
	if (!image) return 0;

	// Get image addr.
	UINT64 imageBaseAddr = image->get_base_address();
	addr_offset = (bbBaseAddr - imageBaseAddr);

    return imageId;
}

bool bbAddr2file(UINT64 bb_addr, DCFG_ID imageId, ofstream &file)
{
	if (file.is_open()) {
		file << "bb " << (void*)bb_addr << " from image " << imageId << endl;
		return true;
	}
	else
		return false;
}

void BuildBBTrace(DCFG_DATA_CPTR dcfg, string tracefile, const char* outputfile)
{
    ofstream ofile;
    ofile.open(outputfile);
    // processes.
    DCFG_ID_VECTOR proc_ids;
    dcfg->get_process_ids(proc_ids);
    for (size_t pi = 0; pi < proc_ids.size(); pi++) {
        DCFG_ID pid = proc_ids[pi];

        // Get info for this process.
        DCFG_PROCESS_CPTR pinfo = dcfg->get_process_info(pid);
        assert(pinfo);

        // Write the addresses of images
        DCFG_ID_VECTOR image_ids;
        pinfo->get_image_ids(image_ids);
        for (size_t ii = 0; ii < image_ids.size(); ii++) {
            DCFG_IMAGE_CPTR iinfo = pinfo->get_image_info(image_ids[ii]);
            assert(iinfo);
            assert(ofile.is_open());
            ofile << "Image " << image_ids[ii] << " " << *(iinfo->get_filename()) 
                << " Load addr = 0x" << hex << iinfo->get_base_address() << dec << endl;
        }

        // Make a new reader.
        DCFG_TRACE_READER* traceReader = DCFG_TRACE_READER::new_reader(pid);

        // threads.
        for (UINT32 tid = 0; tid <= pinfo->get_highest_thread_id(); tid++) {
            string errMsg;
            if (!traceReader->open(tracefile, tid, errMsg)) {
                cerr << "error: " << errMsg << endl;
                return;
            }

            // Read until done.
            size_t nRead = 0;
            bool done = false;
            DCFG_ID_VECTOR edge_ids;
            while (!done) {

                if (!traceReader->get_edge_ids(edge_ids, done, errMsg))
                {
                    cerr << "error: " << errMsg << endl;
                    done = true;
                }
                nRead += edge_ids.size();
                for (size_t j = 0; j < edge_ids.size(); j++) {
                    DCFG_ID edgeId = edge_ids[j];
                    UINT64 bbAddr;
                    DCFG_ID imageId = edgeId2bbAddr(edgeId, pinfo, bbAddr);
                    if (!bbAddr2file(bbAddr, imageId, ofile)) {
                        cerr << "error: unable to write to file: " << outputfile << endl;
                        return;
                    }
                }
                edge_ids.clear();
            }
        }
    }
}

int main(int argc, char* argv[])
{
	if (argc < 4) {
		cerr << "Usage: .. <DCFG_file> <DCFG_trace_file> <Target_file>" << endl;
		return 1;
	}

	// First argument should be a DCFG file.
	string filename = argv[1];

	// Make a new DCFG object.
	DCFG_DATA* dcfg = DCFG_DATA::new_dcfg();

	// Read from file.
	cout << "Reading DCFG from '" << filename << "'..." << endl;
	string errMsg;
	if (!dcfg->read(filename, errMsg)) {
		cerr << "error: " << errMsg << endl;
		return 1;
	}

	// write some summary data from DCFG.
	// summarizeDcfg(dcfg);

	// Second argument should be a DCFG-trace file.

	string tracefile = argv[2];
	// summarizeTrace(dcfg, tracefile);

	// TODO: Turn DCFG-trace to basicblock-trace and write to file
	const char* outputfile = argv[3];
	BuildBBTrace(dcfg, tracefile, outputfile);

	// free memory.
	delete dcfg;

	return 0;
}