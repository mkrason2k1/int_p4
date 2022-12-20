#include <core.p4>
#include <v1model.p4>

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}
header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<8>    diffserv;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}
header UDPheader{
	bit<16> sourceportt
	bit<16> destinationport
	bit<16> length
	bit<16> checksum
}
header int_shim {
	bit<4> type
	bit<2> NPT
	bit<1> R1
	bit<1> R2
	bit<8> length
	bit<16> Udp
}
header int_header {
	bit<4> version
	bit<1> D
	bit<1> E
	bit<1> M
	bit<12> R
	bit<5> hop
	bit<8> remainingHopCount
	bit<16> InstrBit
	bit<16> DomSpec
	bit<16> DSinstr
}
struct headers {
	ethernet_t ethernet
	ipv4_t     ip
	UDPheader  udp
	int_shim   shim
	int_header int_header
}


/* parser */
parser MyParser(packet_in packet, headers hdr) {
	state start{
		transition parse_ethernet;
	}
	state parse_ethernet {
		packet.extract(hdr.ethernet);
		transition select(hdr.ethernet.etherType) {
			

		}
	}
	



}



