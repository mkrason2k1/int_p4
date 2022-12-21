#include <core.p4>
#include <v1model.p4>

header all_headers{
	bit<464> all_bytes;
}
struct headers {
    all_headers   hder;
}

struct metadata{
	bit<32> data;
}

/* parser */
parser MyParser(packet_in packet, out headers hdr, inout metadata meta) {
	state start{
		transition parse_headers;
	}
	state parse_headers {
		packet.extract(hdr.hder);
		transition accept;
	}
}

/* Checksum verification */
control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}



/* Ingress verification  */
control MyIngress(inout headers hdr, inout metadata meta){
	action add_delta() {
		meta.data  = 12;	
	}
	table adding_delta{
		actions = {
			add_delta;
		}

	}
	apply {
		adding_delta.apply();
	}
}

/* Egress verification  */
control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

/* Checksum computation  */
control MyComputeChecksum(inout headers  hdr, inout metadata meta) {
     apply {
    }
}

/* Deparser  */
control MyDeparser(packet_out packet, in headers hdr, inout metadata meta) {
    apply {
        packet.emit(hdr.hder);
        packet.emit(meta.data);
    }
}
/* SWITCH */
V1Switch(
	MyParser(),
	MyVerifyChecksum(),
	MyIngress(),
	MyEgress(),
	MyComputeChecksum(),
	MyDeparser()
) main;
